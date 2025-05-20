import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<T> extends Cubit<T> {
  BaseBloc(T initialState) : super(initialState) {
    onInit();
  }

  void onInit();
}
