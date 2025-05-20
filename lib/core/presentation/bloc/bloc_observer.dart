import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;

class MyBlocObserver extends BlocObserver {
  var logger = Logger();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      developer.log('onCreate -- ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      developer.log('onEvent -- ${bloc.runtimeType}, $event');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      logger.i('onChange -- ${bloc.runtimeType}, $change', stackTrace: StackTrace.empty);
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      developer.log('onTransition -- ${bloc.runtimeType}, $transition');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      logger.e('onError -- ${bloc.runtimeType}, $error');
    }

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      developer.log('onClose -- ${bloc.runtimeType}');
    }
  }
}
