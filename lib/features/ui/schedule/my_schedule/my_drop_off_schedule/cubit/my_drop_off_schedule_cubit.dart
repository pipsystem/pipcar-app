// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';

import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../domain/enterties/entities.dart';

part 'my_drop_off_schedule_state.dart';

@injectable
class MyDropOffScheduleCubit extends BaseBloc<MyDropOffScheduleState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  MyDropOffScheduleCubit(
    this.ticketSupplierUseCase,
  ) : super(MyDropOffScheduleState.initial());

  int page = 1;

  @override
  void onInit() {}

  Future<void> getMyDropOffScheduleList(
      {String? supplierId, bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == MyDropOffScheduleStatus.limit ||
            state.status == MyDropOffScheduleStatus.loadMore) &&
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
          status: MyDropOffScheduleStatus.loadFirst, myDropOffSchedules: []));
    } else {
      emit(state.copyWith(status: MyDropOffScheduleStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketSupplierUseCase
        .getDropOffSchedules(supplierId: supplierId, page: page);
    print(newList.right);
    var currentList = state.myDropOffSchedules;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: MyDropOffScheduleStatus.loaded,
        myDropOffSchedules: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: MyDropOffScheduleStatus.limit));
    }
  }
}
