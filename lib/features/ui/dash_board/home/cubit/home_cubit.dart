import 'package:equatable/equatable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_infor_entity.dart';
import 'package:pipcar/features/domain/enterties/ticket/ticket_supplier_current.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../common/di/di.dart';
import '../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends BaseBloc<HomeState> {
  final AgencyUseCase agencyUseCase;
  final TicketSupplierUseCase ticketSupplierUseCase;
  HomeCubit(this.agencyUseCase, this.ticketSupplierUseCase) : super(HomeState.initial());

  @override
  void onInit() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final result = await agencyUseCase.getAgencyInfor();
    final resultCurrentAcceptedTicket = await ticketSupplierUseCase.getCurrentAcceptedTicket();
    resultCurrentAcceptedTicket.fold(
        (left) {}, (right) {
          state.currentTicketId = right.currentTicketId;
        }
    );
    result.fold(
        (left) => getIt.get<DialogBloc>().showAlertDialog(
            title: translate("announce"), message: left.toString()), (right) {
      emit(state.copyWith(status: HomeStatus.loaded, agencyInfor: right));
      LocalStorage.agencyId.val = (right as AgencyInforEntity).agencyId;
      LocalStorage.carTypeId.val = right.carTypeId;
    });
  }
}
