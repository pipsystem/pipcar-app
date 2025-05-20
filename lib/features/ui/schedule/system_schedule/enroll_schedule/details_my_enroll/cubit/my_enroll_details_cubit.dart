// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'my_enroll_details_state.dart';

@injectable
class MyEnrollDetailsCubit extends BaseBloc<MyEnrollDetailsState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyEnrollDetailsCubit(
    this.ticketSupplierUseCase,
  ) : super(MyEnrollDetailsState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsMyEnrollTicket(String ticketId) async {
    emit(state.copyWith(status: MyEnrollDetailsStatus.loading));
    final result = await ticketSupplierUseCase.getDetailsMyApplyTicket(ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: MyEnrollDetailsStatus.loaded, details: right)),
    );
  }

  Future<void> cancelApply(String ticketId) async {
    emit(state.copyWith(status: MyEnrollDetailsStatus.loading));
    final result = await ticketSupplierUseCase.cancelApplyTicket(ticketId);
    emit(state.copyWith(status: MyEnrollDetailsStatus.loaded));
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: MyEnrollDetailsStatus.cancel)),
    );
  }
}
