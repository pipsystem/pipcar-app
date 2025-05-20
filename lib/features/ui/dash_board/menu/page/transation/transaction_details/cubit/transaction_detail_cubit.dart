// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/features/domain/enterties/transaction/transaction_detail_entity.dart';
import 'package:pipcar/features/domain/use_case/transaction_use_case.dart';

import '../../../../../../../../common/di/di.dart';

part 'transaction_detail_state.dart';

@injectable
class TransactionDetailCubit extends BaseBloc<TransactionDetailState> {
  final TransactionUseCase _useCase;
  TransactionDetailCubit(
    this._useCase,
  ) : super(TransactionDetailState.init());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  void getData(String transacitonId) async {
    emit(state.copyWith(status: TransactionDetailStatus.loading));
    final result = await _useCase.getDetailTransaction(transacitonId);
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(state.copyWith(
            status: TransactionDetailStatus.loaded, detail: right)));
  }
}
