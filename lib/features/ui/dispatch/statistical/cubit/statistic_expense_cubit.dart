// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/dispatch/analyst_angency_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

part 'statistic_expense_state.dart';

@injectable
class StatisticExpenseCubit extends BaseBloc<StatisticExpenseState> {
  final AgencyUseCase _useCase;
  StatisticExpenseCubit(
    this._useCase,
  ) : super(StatisticExpenseState.init());

  @override
  void onInit() {
    getData();
  }

  Future<void> getData() async {
    final result = await _useCase.getAnalystExpense();
    result.fold((left) => emit(StatisticExpenseState.error()),
        (right) => emit(StatisticExpenseState(detailExpense: right)));
  }
}
