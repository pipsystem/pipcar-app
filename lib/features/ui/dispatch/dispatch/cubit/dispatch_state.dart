// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dispatch_cubit.dart';

class DispatchState extends Equatable {
  final InforDriverDispatchEntity? driverInfor;
  const DispatchState({this.driverInfor});

  factory DispatchState.init() => const DispatchState();

  @override
  List<Object?> get props => [driverInfor];

  DispatchState copyWith({
    InforDriverDispatchEntity? driverInfor,
  }) {
    return DispatchState(
      driverInfor: driverInfor ?? this.driverInfor,
    );
  }
}
