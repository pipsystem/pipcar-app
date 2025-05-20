part of 'loading_bloc.dart';

enum LoadingStatus {
  initial,
  loading,
  finish,
}

class LoadingState extends Equatable {
  final LoadingStatus status;

  const LoadingState({required this.status});

  factory LoadingState.initial() =>
      const LoadingState(status: LoadingStatus.initial);

  LoadingState copyWith({LoadingStatus? status}) =>
      LoadingState(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
