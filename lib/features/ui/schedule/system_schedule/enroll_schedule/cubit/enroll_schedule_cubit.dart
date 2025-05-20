// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../domain/enterties/entities.dart';

part 'enroll_schedule_state.dart';

@injectable
class EnrollScheduleCubit extends BaseBloc<EnrollScheduleState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  EnrollScheduleCubit(
    this.ticketSupplierUseCase,
  ) : super(EnrollScheduleState.initial());

  int page = 1;

  @override
  void onInit() {}

  Future<void> getEnrollScheduleList(
      {String? supplierId, bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == EnrollScheduleStatus.limit ||
            state.status == EnrollScheduleStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state.copyWith(
          status: EnrollScheduleStatus.loadFirst, enrollSchedules: []));
    } else {
      emit(state.copyWith(status: EnrollScheduleStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketSupplierUseCase
        .getApplySchedules(supplierId: supplierId, page: page);
    var currentList = state.enrollSchedules;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: EnrollScheduleStatus.loaded, enrollSchedules: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: EnrollScheduleStatus.limit));
    }
  }
}
