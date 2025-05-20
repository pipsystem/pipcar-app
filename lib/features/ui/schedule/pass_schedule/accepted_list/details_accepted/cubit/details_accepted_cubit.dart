// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_owner_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../core/presentation/bloc/loading_bloc/loading_bloc.dart';
import '../../../../../../domain/enterties/entities.dart';

part 'details_accepted_state.dart';

@injectable
class DetailsAcceptedCubit extends BaseBloc<DetailsAcceptedState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  DetailsAcceptedCubit(
    this.ticketOwnerUseCase,
  ) : super(DetailsAcceptedState.initial());

  final TextEditingController nameCustomerController = TextEditingController();
  final TextEditingController phoneCustomerController = TextEditingController();

  @override
  Future<void> close() {
    nameCustomerController.dispose();
    phoneCustomerController.dispose();
    return super.close();
  }

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsAcceptedTicket(String ticketId) async {
    emit(state.copyWith(status: DetailsAcceptedStatus.loading));
    final result = await ticketOwnerUseCase.getDetailsAcceptedTicket(ticketId: ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) {
        emit(state.copyWith(status: DetailsAcceptedStatus.loaded, details: right));
      },
    );
  }

  Future<void> cancelTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.cancelTicket(ticketId: ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsAcceptedStatus.cancel)),
    );
  }

  Future<void> completeTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.completeTicket(ticketId: ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: DetailsAcceptedStatus.completeSuccess)),
    );
  }

  Future<void> updateTicketCustomer() async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketOwnerUseCase.updateTicketCustomer(
        ticketId: state.details!.ticketInfor.ticketId,
        customerName: nameCustomerController.text.trim(),
        customerPhone: phoneCustomerController.text.trim());
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => getDetailsAcceptedTicket(state.details!.ticketInfor.ticketId),
    );
  }
}
