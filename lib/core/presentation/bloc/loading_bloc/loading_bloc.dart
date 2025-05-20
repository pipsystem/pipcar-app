import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'loading_state.dart';

@lazySingleton
class LoadingBloc extends Cubit<LoadingState> {
  LoadingBloc()
      : super(
          LoadingState.initial(),
        );

  Future<void> startLoading() async {
    emit(
      state.copyWith(status: LoadingStatus.loading),
    );
  }

  Future<void> finishLoading() async {
    emit(
      state.copyWith(status: LoadingStatus.finish),
    );
  }
}
