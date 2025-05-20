// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_cubit.dart';

enum InternetStatus { initial, connected, disconnected }

class InternetState extends Equatable {
  final InternetStatus status;
  const InternetState(
    this.status,
  );

  factory InternetState.init() => const InternetState(InternetStatus.connected);

  @override
  List<Object> get props => [status];

  InternetState copyWith({
    InternetStatus? status,
  }) {
    return InternetState(
      status ?? this.status,
    );
  }
}
