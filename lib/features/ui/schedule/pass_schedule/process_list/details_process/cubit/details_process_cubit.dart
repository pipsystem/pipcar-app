import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/loading_bloc/loading_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../core/presentation/bloc/loading_bloc/loading_bloc.dart';
import '../../../../../../domain/enterties/entities.dart';

part 'details_process_state.dart';

@injectable
class DetailsProcessCubit extends BaseBloc<DetailsProcessState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  // final AgencyUseCase agencyUseCase;
  DetailsProcessCubit(this.ticketOwnerUseCase) : super(DetailsProcessState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsProcessTicket(String ticketId) async {
    emit(state.copyWith(status: DetailsProcessStatus.loading));
    final result = await ticketOwnerUseCase.getDetailsProcessTicket(ticketId: ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsProcessStatus.loaded, details: right)),
    );
  }
  Future<void> completeTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.completeTicket(ticketId: ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
          (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
          (right) => emit(state.copyWith(status: DetailsProcessStatus.completeSuccess)),
    );
  }
}
