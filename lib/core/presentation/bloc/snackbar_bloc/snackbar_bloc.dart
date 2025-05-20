import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'snackbar_state.dart';
part 'snackbar_type.dart';

@lazySingleton
class SnackbarBloc extends Cubit<SnackbarState> {
  SnackbarBloc() : super(InitialSnackbarState());

  Future<void> showSnackbar(
      {required String translationKey,
      SnackBarType type = SnackBarType.error,
      List<dynamic>? params,
      Key? key}) async {
    emit(
      ShowSnackBarState(
        translationKey: translationKey,
        type: type,
        params: params ?? [],
        key: key,
      ),
    );
  }
}
