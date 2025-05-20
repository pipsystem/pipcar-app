// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/di/di.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../domain/enterties/entities.dart';

part 'new_schedule_state.dart';

@injectable
class NewScheduleCubit extends BaseBloc<NewScheduleState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  NewScheduleCubit(
    this.ticketSupplierUseCase,
  ) : super(NewScheduleState.initial());

  int page = 1;

  @override
  void onInit() {}

  Future<void> getNewScheduleList(
      {String? supplierId, bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == NewScheduleStatus.limit ||
            state.status == NewScheduleStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state
          .copyWith(status: NewScheduleStatus.loadFirst, newSchedules: []));
    } else {
      emit(state.copyWith(status: NewScheduleStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketSupplierUseCase
        .getNewScheduleList(supplierId: supplierId, page: page);
    var currentList = state.newSchedules;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: NewScheduleStatus.loaded, newSchedules: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: NewScheduleStatus.limit));
    }
  }

  Future<void> applyTicket(String ticketId) async {
    getIt.get<DialogBloc>().showOptionDialog(
          message:
              "Chủ lịch sẽ dựa theo vị trí hiện tại của lái xe để quyết định giao lịch. Xe không có khả năng thực hiện lịch, vui lòng không bổ lịch.",
          acceptAction: () async {
            final result = await ticketSupplierUseCase.applyTicket(ticketId);
            result.fold(
              (left) => getIt
                  .get<DialogBloc>()
                  .showAlertDialog(message: left.toString()),
              (right) =>
                  emit(state.copyWith(status: NewScheduleStatus.applySuccess)),
            );
          },
        );
  }
}
