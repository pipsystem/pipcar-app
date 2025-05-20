import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';
import '../../../../../domain/use_case/ticket_owner_use_case.dart';

part 'accepted_list_state.dart';

@injectable
class AcceptedListCubit extends BaseBloc<AcceptedListState> {
  final TicketOwnerUseCase ticketOwnerUseCase;
  AcceptedListCubit(this.ticketOwnerUseCase) : super(AcceptedListState.initial());

  int page = 1;

  @override
  void onInit() {
    getAcceptedList();
  }

  Future<void> getAcceptedList({bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == AcceptedListStatus.limit || state.status == AcceptedListStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load lan dau
    if (page == 1) {
      emit(state.copyWith(status: AcceptedListStatus.loadFirst, acceptedList: []));
    } else {
      emit(state.copyWith(status: AcceptedListStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList = await ticketOwnerUseCase.getAcceptedList(page: page);
    var currentList = state.acceptedList;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(status: AcceptedListStatus.loaded, acceptedList: currentList));
    if (newList.right.length < 5) {
      emit(state.copyWith(status: AcceptedListStatus.limit));
    }
  }
}
