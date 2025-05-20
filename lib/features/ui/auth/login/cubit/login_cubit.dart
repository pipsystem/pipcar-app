import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/login_entity.dart';
import 'package:pipcar/features/domain/use_case/authen_use_case.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends BaseBloc<LoginState> {
  final AuthenUseCase authenUseCase;
  LoginCubit(this.authenUseCase) : super(LoginInitial());

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    otpController.dispose();
    return super.close();
  }

  Future<void> login() async {
    final result = await authenUseCase.login(
        phone: phoneController.text.trim(), otp: otpController.text.trim());
    result.fold(
        (left) => getIt.get<DialogBloc>().showAlertDialog(
            title: translate("announce"), message: left.toString()), (right) {
      var loginEntity = right as LoginEntity;
      LocalStorage.saveToken(
          aT: loginEntity.accessToken, rT: loginEntity.refreshToken);
      getIt.get<AuthenticationCubit>().onAuthenSuccess();
    });
  }
}
