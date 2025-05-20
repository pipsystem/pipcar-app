import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';

import '../../../../common/di/di.dart';
import '../snackbar_bloc/snackbar_bloc.dart';

part 'internet_state.dart';

@injectable
class InternetCubit extends BaseBloc<InternetState> {
  InternetCubit() : super(InternetState.init());

  late StreamSubscription internetSubcription;

  @override
  void onInit() {
    internetSubcription = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (state.status == InternetStatus.disconnected) {
            getIt
                .get<SnackbarBloc>()
                .showSnackbar(translationKey: translate("internet_connected"), type: SnackBarType.internetConnected);
          }
          emit(state.copyWith(status: InternetStatus.connected));
          break;
        case InternetConnectionStatus.disconnected:
          emit(state.copyWith(status: InternetStatus.disconnected));
          break;
      }
    });
  }

  @override
  Future<void> close() {
    internetSubcription.cancel();
    return super.close();
  }
}
