// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

import 'package:pipcar/features/domain/use_case/authen_use_case.dart';

import '../../../../common/di/di.dart';
import '../../../../common/local_storage/local_storage.dart';
import '../../../../common/utils/utils_src.dart';
import '../base_bloc/base_bloc.dart';
import '../dialog_bloc/dialog_bloc.dart';

part 'auth_state.dart';

@lazySingleton
class AuthenticationCubit extends BaseBloc<AuthenticationState> {
  final AuthenUseCase authenUseCase;
  final AgencyUseCase agencyUseCase;
  AuthenticationCubit(
    this.authenUseCase,
    this.agencyUseCase,
  ) : super(const AuthenticationState.unknown());

  Timer? timer;

  @override
  void onInit() {}

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  Future<void> updateDeviceId() async {
    if (!isNullEmpty(LocalStorage.deviceId.val)) {
      await authenUseCase.updateDeviceId(LocalStorage.deviceId.val);
    } else {
      await FirebaseMessaging.instance.getToken().then((value) async {
        log('Generated fcm token without local: $value');
        if (value != null) {
          await authenUseCase.updateDeviceId(value);
        }
      }, onError: (err) {
        log('Get Token Firebase Messaging without local failed: $err');
        // showAlertDialog("Thông báo", "Không thể kết nối đến server. Vui lòng thử lại sau", "OK", () {});
      });
    }
  }

  Future<void> checkRefreshToken() async {
    log("1");
    final aT = LocalStorage.accessToken.val;
    final rT = LocalStorage.refreshToken.val;
    if (aT == "" || rT == "") {
      await authenUseCase.trackingAuth(agencyId: LocalStorage.agencyId.val, title: "Tracking", description: "Access Token is null or Refresh token is null");
      emit(const AuthenticationState.unauthenticated());
    } else {
      var hasInternet = await InternetConnectionChecker().hasConnection;
      if (!hasInternet) {
        emit(const AuthenticationState.authenticated());
        return;
      }

      final result = await authenUseCase.checkRT(refreshToken: rT);
      result.fold((left) async {
        if (left.toString() == "Server Error") {
          emit(const AuthenticationState.serverError());
        } else {
          await authenUseCase.trackingAuth(agencyId: LocalStorage.agencyId.val, title: "Tracking", description: "Refresh Token is not available");
          emit(const AuthenticationState.unauthenticated());
        }
      }, (right) async {
        if (right.accessToken == "") {
          await authenUseCase.trackingAuth(agencyId: LocalStorage.agencyId.val, title: "Tracking", description: "Access Token is null");
          emit(const AuthenticationState.unauthenticated());
        } else {
          LocalStorage.saveToken(aT: right.accessToken, rT: rT);
          // emit(const AuthenticationState.authenticated());
          onAuthenSuccess();
        }
      });
    }
  }

  Future<void> onAuthenSuccess() async {
    emit(const AuthenticationState.authenticated());
    checkAuthenAndUpdateGPS();
  }

  void checkAuthenAndUpdateGPS() {
    if (state.status == AuthenticationStatus.authenticated) {
      agencyUseCase.updateGPS();
      updateDeviceId();
      timer = Timer.periodic(const Duration(minutes: 2), (timer) {
        agencyUseCase.updateGPS();
      });
    }
  }

  void killTimer() {
    timer?.cancel();
  }

  Future<void> onLogoutRequested() async {
    getIt.get<DialogBloc>().showOptionDialog(
        title: "Thông báo",
        message: "Bạn có chắc chắn muốn thoát?",
        acceptAction: () async {
          final resutl = await authenUseCase.logOut();
          resutl.fold(
              (left) => getIt.get<DialogBloc>().showAlertDialog(
                  title: translate("announce"),
                  message: left.toString()), (right) {
            LocalStorage.clearToken();
            emit(const AuthenticationState.unauthenticated());
            timer?.cancel();
          });
        });
  }

  Future<void> onLogout() async {
    await authenUseCase.trackingAuth(agencyId: LocalStorage.agencyId.val, title: "Crashed", description: "Account has been logged in with another device");
    LocalStorage.clearToken();
    emit(const AuthenticationState.unauthenticated());
    timer?.cancel();
  }

  // void navigatorInitRoute() {
  //   String accessToken = LocalStorage.accessToken.val;
  //   if (accessToken != '') {
  //     emit(const AuthenticationState.authenticated());
  //   } else {
  //     emit(const AuthenticationState.unauthenticated());
  //   }
  // }
}
