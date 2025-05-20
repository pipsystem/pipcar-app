// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'menu_cubit.dart';

enum MenuStatus { init, loading, loaded }

class MenuState extends Equatable {
  final MenuStatus status;
  final AgencyInforEntity? agencyInfor;
  const MenuState({required this.status, this.agencyInfor});

  factory MenuState.initial() => const MenuState(status: MenuStatus.init);

  @override
  List<Object> get props => [status, agencyInfor ?? ""];

  MenuState copyWith({
    MenuStatus? status,
    AgencyInforEntity? agencyInfor,
  }) {
    return MenuState(
      status: status ?? this.status,
      agencyInfor: agencyInfor ?? this.agencyInfor,
    );
  }
}
