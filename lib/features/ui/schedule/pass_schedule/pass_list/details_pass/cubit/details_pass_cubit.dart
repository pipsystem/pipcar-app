import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_search_infor_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../domain/enterties/entities.dart';

part 'details_pass_state.dart';

@injectable
class DetailsPassCubit extends BaseBloc<DetailsPassState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  // final AgencyUseCase agencyUseCase;
  DetailsPassCubit(this.ticketOwnerUseCase) : super(DetailsPassState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsPassTicket(String ticketId) async {
    emit(state.copyWith(status: DetailsPassStatus.loading));
    final result = await ticketOwnerUseCase.getDetailsPassTicket(ticketId: ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsPassStatus.loaded, details: right)),
    );
  }

  Future<void> acceptTicket({required String ticketId, required String supplierId}) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.acceptTicket(ticketId: ticketId, supplierId: supplierId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsPassStatus.handoverSuccess)),
    );
  }

  Future<void> cancelTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.cancelTicket(ticketId: ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsPassStatus.cancel)),
    );
  }

  Future<void> passAgain() async {
    emit(state.copyWith(status: DetailsPassStatus.passAgainSuccess));
  }
}
