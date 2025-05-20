// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/utils/app_utils.dart';

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/dispatch/infor_driver_dispatch_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

part 'dispatch_state.dart';

@injectable
class DispatchCubit extends BaseBloc<DispatchState> {
  final AgencyUseCase agencyUseCase;
  DispatchCubit(
    this.agencyUseCase,
  ) : super(DispatchState.init());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsDriverDispatch(String agencyId) async {
    final result = await agencyUseCase.getDetailsDriverDispatch(agencyId);
    result.fold((left) => AppUtils.showToast("Get details driver failed"),
        (right) => emit(state.copyWith(driverInfor: right)));
  }
}
