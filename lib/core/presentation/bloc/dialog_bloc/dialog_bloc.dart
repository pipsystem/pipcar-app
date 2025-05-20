import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'dialog_state.dart';

@lazySingleton
class DialogBloc extends Cubit<DialogState> {
  DialogBloc()
      : super(
          InitialDialogState(),
        );

  void showAlertDialog({
    String? title,
    String? mainMessage,
    String? message,
    String? buttonTitle,
    String? textTransfer,
    VoidCallback? settingAction,
    VoidCallback? acceptAction,
  }) {
    emit(ShowAlertDialogState(
      title: title,
      mainMessage: mainMessage,
      message: message,
      buttonTitle: buttonTitle,
      textTransfer: textTransfer,
      settingAction: settingAction,
      acceptAction: acceptAction,
    ));
  }

  void showOptionDialog({
    String? title,
    String? message,
    String? buttonTitle,
    VoidCallback? acceptAction,
    VoidCallback? denyAction,
  }) {
    emit(ShowOptionDialogState(
      title: title,
      message: message,
      buttonTitle: buttonTitle,
      acceptAction: acceptAction,
      denyAction: denyAction,
    ));
  }
}
