import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';

import '../../../../../domain/use_case/ticket_owner_use_case.dart';

part 'complete_list_state.dart';

@injectable
class CompleteListCubit extends BaseBloc<CompleteListState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  CompleteListCubit(this.ticketOwnerUseCase) : super(CompleteListState.initial());

  int page = 1;

  @override
  void onInit() {
    getCompleteList();
  }

  Future<void> getCompleteList({bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == CompleteListStatus.limit || state.status == CompleteListStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state.copyWith(status: CompleteListStatus.loadFirst, completeList: []));
    } else {
      emit(state.copyWith(status: CompleteListStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketOwnerUseCase.getCompleteList(page: page);
    var currentList = state.completeList;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(status: CompleteListStatus.loaded, completeList: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: CompleteListStatus.limit));
    }
  }
}
