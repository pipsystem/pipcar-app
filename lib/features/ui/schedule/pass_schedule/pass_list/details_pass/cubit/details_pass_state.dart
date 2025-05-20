// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'details_pass_cubit.dart';

enum DetailsPassStatus { init, loading, loaded, cancel, handoverSuccess, passAgainSuccess}

class DetailsPassState extends Equatable {
  final DetailsPassStatus status;
  final DetailsPassTicket? details;
  final AgencySearchInforEntity? agencySearchInfor;
  const DetailsPassState({required this.status, required this.details, this.agencySearchInfor});

  factory DetailsPassState.initial() => const DetailsPassState(status: DetailsPassStatus.init, details: null);

  @override
  List<Object> get props => [status, details ?? ""];

  DetailsPassState copyWith({
    DetailsPassStatus? status,
    DetailsPassTicket? details,
    AgencySearchInforEntity? agencySearchInfor,
  }) {
    return DetailsPassState(
      status: status ?? this.status,
      details: details ?? this.details,
      agencySearchInfor: agencySearchInfor ?? this.agencySearchInfor
    );
  }
}
