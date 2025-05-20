import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_owner_process.dart';

import '../../../../../domain/use_case/ticket_owner_use_case.dart';

part 'process_list_state.dart';

@injectable
class ProcessListCubit extends BaseBloc<ProcessListState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  ProcessListCubit(this.ticketOwnerUseCase) : super(ProcessListState.initial());

  int page = 1;

  @override
  void onInit() {
    getProcessList();
  }

  Future<void> getProcessList({bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == ProcessListStatus.limit || state.status == ProcessListStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state.copyWith(status: ProcessListStatus.loadFirst, processList: []));
    } else {
      emit(state.copyWith(status: ProcessListStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketOwnerUseCase.getProcessList(page: page);
    var currentList = state.processList;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(status: ProcessListStatus.loaded, processList: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: ProcessListStatus.limit));
    }
  }
}
