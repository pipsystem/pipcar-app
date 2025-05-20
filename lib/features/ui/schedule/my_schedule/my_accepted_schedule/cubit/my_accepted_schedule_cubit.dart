// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';

import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../domain/enterties/entities.dart';

part 'my_accepted_schedule_state.dart';

@injectable
class MyAcceptedScheduleCubit extends BaseBloc<MyAcceptedScheduleState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyAcceptedScheduleCubit(
    this.ticketSupplierUseCase,
  ) : super(MyAcceptedScheduleState.initial());

  int page = 1;

  @override
  void onInit() {}

  Future<void> getMyAcceptedScheduleList(
      {String? supplierId, bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == MyAcceptedScheduleStatus.limit ||
            state.status == MyAcceptedScheduleStatus.loadMore) &&
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
          status: MyAcceptedScheduleStatus.loadFirst, myAcceptedSchedules: []));
    } else {
      emit(state.copyWith(status: MyAcceptedScheduleStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketSupplierUseCase
        .getMyAcceptedSchedules(page: page, supplierId: supplierId);
    var currentList = state.myAcceptedSchedules;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: MyAcceptedScheduleStatus.loaded,
        myAcceptedSchedules: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: MyAcceptedScheduleStatus.limit));
    }
  }
}
