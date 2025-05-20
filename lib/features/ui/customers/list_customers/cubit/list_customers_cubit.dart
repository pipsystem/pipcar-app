import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/domain/enterties/customer/customer_entity.dart';
import 'package:pipcar/features/domain/use_case/customers_use_case.dart';

import '../../../../../common/di/di.dart';
import '../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'list_customers_state.dart';

@injectable
class ListCustomersCubit extends BaseBloc<ListCustomersState> {
  final CustomersUseCase customersUseCase;
  ListCustomersCubit(this.customersUseCase) : super(ListCustomersState.initial());

  @override
  void onInit() {
    getListCustomers();
  }

  Future<void> getListCustomers() async {
    emit(state.copyWith(status: ListCustomersStatus.loading));
    final result = await customersUseCase.getListCustomers();
    result.fold(
          (left) =>
          getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
          (right) {
        var listCustomers = (right as List<CustomersEntity>);
        emit(
          state.copyWith(
              status: ListCustomersStatus.loaded, customers: listCustomers),
        );
      },
    );
  }
}