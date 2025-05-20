// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'statistic_expense_cubit.dart';

class StatisticExpenseState extends Equatable {
  final AnalystExpenseEntity? detailExpense;
  const StatisticExpenseState({
    this.detailExpense,
  });

  factory StatisticExpenseState.init() =>
      StatisticExpenseState(detailExpense: AnalystExpenseEntity.empty());

  factory StatisticExpenseState.error() =>
      const StatisticExpenseState(detailExpense: null);

  @override
  List<Object?> get props => [detailExpense];
}
