// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../domain/enterties/entities.dart';

part 'details_complete_state.dart';

@injectable
class DetailsCompleteCubit extends BaseBloc<DetailsCompleteState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  DetailsCompleteCubit(
    this.ticketOwnerUseCase,
  ) : super(DetailsCompleteState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsCompleteTicket(String ticketId) async {
    emit(state.copyWith(status: DetailsCompleteStatus.loading));
    final result = await ticketOwnerUseCase.getDetailsCompleteTicket(ticketId: ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsCompleteStatus.loaded, details: right)),
    );
  }
}
