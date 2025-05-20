import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_owner_pass.dart';

import '../../../../../domain/use_case/ticket_owner_use_case.dart';

part 'pass_list_state.dart';

@injectable
class PassListCubit extends BaseBloc<PassListState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  PassListCubit(this.ticketOwnerUseCase) : super(PassListState.initial());

  int page = 1;

  @override
  void onInit() {
    getPassList();
  }

  Future<void> getPassList({bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == PassListStatus.limit ||
            state.status == PassListStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state.copyWith(status: PassListStatus.loadFirst, passList: []));
    } else {
      emit(state.copyWith(status: PassListStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList =
        await ticketOwnerUseCase.getPassList(page: page);
    var currentList = state.passList;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(status: PassListStatus.loaded, passList: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: PassListStatus.limit));
    }
  }
}
