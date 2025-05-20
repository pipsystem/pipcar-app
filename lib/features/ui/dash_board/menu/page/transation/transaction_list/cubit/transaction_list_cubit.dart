import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/transaction_use_case.dart';

import '../../../../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';

part 'transaction_list_state.dart';

@injectable
class TransactionListCubit extends BaseBloc<TransactionListState> {
  final TransactionUseCase _useCase;
  TransactionListCubit(this._useCase) : super(TransactionListState.initial());

  int page = 1;

  @override
  void onInit() {
    getListTransaction();
  }

  Future<void> getListTransaction({bool isOnRefresh = false}) async {
    //limit trang
    if ((state.status == TransactionListStatus.limit ||
            state.status == TransactionListStatus.loadMore) &&
        isOnRefresh == false) {
      return;
    }
    // neu onrefresh => restet page
    if (isOnRefresh == true) {
      page = 1;
    }
    // Load first
    if (page == 1) {
      emit(state
          .copyWith(status: TransactionListStatus.loadFirst, transactions: []));
    } else {
      emit(state.copyWith(status: TransactionListStatus.loadMore));
    }
    //load more
    Either<Exception, dynamic> newList =
        await _useCase.getListTransaction(page);
    var currentList = state.transactions;
    page++;
    currentList = [
      ...currentList,
      ...newList.right,
    ];
    emit(state.copyWith(
        status: TransactionListStatus.loaded, transactions: currentList));
    if (newList.right.length < 10) {
      emit(state.copyWith(status: TransactionListStatus.limit));
    }
  }
}
