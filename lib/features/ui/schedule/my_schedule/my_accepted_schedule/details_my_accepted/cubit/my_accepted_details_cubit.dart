// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../core/presentation/bloc/loading_bloc/loading_bloc.dart';

part 'my_accepted_details_state.dart';

@injectable
class MyAcceptedDetailsCubit extends BaseBloc<MyAcceptedDetailsState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyAcceptedDetailsCubit(
    this.ticketSupplierUseCase,
  ) : super(MyAcceptedDetailsState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsMyAcceptedTicket(String ticketId) async {
    emit(state.copyWith(status: MyAcceptedDetailsStatus.loading));
    final result =
        await ticketSupplierUseCase.getDetailsMyAcceptedTicket(ticketId);
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(
          status: MyAcceptedDetailsStatus.loaded, details: right)),
    );
  }

  Future<void> dropOffTicket(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketSupplierUseCase.dropOffTicket(ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: MyAcceptedDetailsStatus.dropOff)),
    );
  }

  Future<void> pickUpClient(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketSupplierUseCase.pickUp(ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: MyAcceptedDetailsStatus.pickUp)),
    );
  }

  Future<void> deleteTicketNavigate(String ticketId) async {
    getIt.get<LoadingBloc>().startLoading();
    final result = await ticketSupplierUseCase.deleteTicketNavigate(ticketId);
    getIt.get<LoadingBloc>().finishLoading();
    result.fold(
      (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) =>
          emit(state.copyWith(status: MyAcceptedDetailsStatus.deleteNavigate)),
    );
  }
}
