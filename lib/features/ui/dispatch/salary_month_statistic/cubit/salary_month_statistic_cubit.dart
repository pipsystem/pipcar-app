// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/dispatch/salary_statistic_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

part 'salary_month_statistic_state.dart';

@injectable
class SalaryMonthStatisticCubit extends BaseBloc<SalaryMonthStatisticState> {
  final AgencyUseCase _useCase;
  SalaryMonthStatisticCubit(
    this._useCase,
  ) : super(SalaryMonthStatisticState.init());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getData(String supplierId) async {
    final result = await _useCase.getSalaryStatistic(supplierId);
    result.fold((left) => emit(SalaryMonthStatisticState.error()),
        (right) => emit(SalaryMonthStatisticState(salarys: right)));
  }
}
