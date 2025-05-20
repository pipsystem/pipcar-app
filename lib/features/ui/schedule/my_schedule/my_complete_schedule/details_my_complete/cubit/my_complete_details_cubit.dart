// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'my_complete_details_state.dart';

@injectable
class MyCompleteDetailsCubit extends BaseBloc<MyCompleteDetailsState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyCompleteDetailsCubit(
    this.ticketSupplierUseCase,
  ) : super(MyCompleteDetailsState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsMyCompleteTicket(String ticketId) async {
    emit(state.copyWith(status: MyCompleteDetailsStatus.loading));
    final result = await ticketSupplierUseCase.getDetailsMyCompleteTicket(ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: MyCompleteDetailsStatus.loaded, details: right)),
    );
  }
}
