part of 'salary_month_statistic_cubit.dart';

class SalaryMonthStatisticState extends Equatable {
  final List<SalaryStatisticEntity>? salarys;
  const SalaryMonthStatisticState({
    this.salarys,
  });

  factory SalaryMonthStatisticState.init() =>
      const SalaryMonthStatisticState(salarys: []);

  factory SalaryMonthStatisticState.error() =>
      const SalaryMonthStatisticState(salarys: null);

  @override
  List<Object?> get props => [salarys];
}
