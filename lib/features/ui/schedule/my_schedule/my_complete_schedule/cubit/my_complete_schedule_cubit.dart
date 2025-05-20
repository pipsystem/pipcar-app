// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../domain/enterties/entities.dart';

part 'my_complete_schedule_state.dart';

@injectable
class MyCompleteScheduleCubit extends BaseBloc<MyCompleteScheduleState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyCompleteScheduleCubit(
    this.ticketSupplierUseCase,
  ) : super(MyCompleteScheduleState.initial());

  int page = 1;

  @override
  void onInit() {}

  Future<void> getMyCompleteScheduleList(
      {String? supplierId, bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == MyCompleteScheduleStatus.limit ||
            state.status == MyCompleteScheduleStatus.loadMore) &&
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
          status: MyCompleteScheduleStatus.loadFirst, myCompleteSchedules: []));
    } else {
      emit(state.copyWith(status: MyCompleteScheduleStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketSupplierUseCase
        .getMyCompleteSchedules(supplierId: supplierId, page: page);
    var currentList = state.myCompleteSchedules;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: MyCompleteScheduleStatus.loaded,
        myCompleteSchedules: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: MyCompleteScheduleStatus.limit));
    }
  }
}
