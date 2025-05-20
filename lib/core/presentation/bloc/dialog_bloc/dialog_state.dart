part of 'dialog_bloc.dart';

abstract class DialogState {
  final Key? key;
  final String? title;
  final String? mainMessage;
  final String? message;
  final String? buttonTitle;
  final String? textTransfer;
  final Function()? settingAction;
  final Function()? acceptAction;
  final Function()? denyAction;
  DialogState({
    this.title,
    this.mainMessage,
    this.message,
    this.buttonTitle,
    this.textTransfer,
    this.settingAction,
    this.acceptAction,
    this.denyAction,
    this.key,
  });
}

class InitialDialogState extends DialogState {}

class ShowAlertDialogState extends DialogState {
  ShowAlertDialogState({
    title,
    mainMessage,
    message,
    buttonTitle,
    textTransfer,
    settingAction,
    acceptAction,
    Key? key,
  }) : super(
          title: title,
          mainMessage: mainMessage,
          message: message,
          buttonTitle: buttonTitle,
          textTransfer: textTransfer,
          settingAction: () => settingAction,
          acceptAction: () => acceptAction,
          key: key,
        );
}

class ShowOptionDialogState extends DialogState {
  ShowOptionDialogState({
    title,
    message,
    buttonTitle,
    acceptAction,
    denyAction,
    Key? key,
  }) : super(
          title: title,
          message: message,
          buttonTitle: buttonTitle,
          acceptAction: () => acceptAction,
          denyAction: () => denyAction,
          key: key,
        );
}
