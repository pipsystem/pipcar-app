// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:pipcar/core/presentation/bloc/location_bloc/location_cubit.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/domain/use_case/ticket_supplier_use_case.dart';

import '../../../../../../../common/di/di.dart';
import '../../../../../../../core/presentation/bloc/base_bloc/base_bloc.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

part 'new_details_state.dart';

@injectable
class NewDetailsCubit extends BaseBloc<NewDetailsState> {
  final TicketSupplierUseCase ticketSupplierUseCase;
  NewDetailsCubit(
    this.ticketSupplierUseCase,
  ) : super(NewDetailsState.initial());

  @override
  void onInit() {
    // TODO: implement onInit
  }

  Future<void> getDetailsNewTicket(String ticketId) async {
    emit(state.copyWith(status: NewDetailsStatus.loading));
    final result = await ticketSupplierUseCase.getDetailsNewTicket(ticketId);
    result.fold(
      (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
      (right) => emit(state.copyWith(status: NewDetailsStatus.loaded, details: right)),
    );
  }

  Future<void> applyTicket(String ticketId) async {
    getIt.get<DialogBloc>().showOptionDialog(
          message:
              "Chủ lịch sẽ dựa theo vị trí xe và các thông tin đánh giá về tài xế trước đó để quyết định giao lịch.\n\nXe không có khả năng thực hiện lịch, vui lòng không bổ lịch.",
          acceptAction: () async {
            PermissionStatus permissionStatus = await LocationCubit().checkPermissionAndOpenSettings();
            // ignore: unrelated_type_equality_checks
            if(permissionStatus != PermissionStatus.granted){
              getIt.get<DialogBloc>().showAlertDialog(
                message: "Quý khách hãy cấp quyền truy\ncập GPS để tiếp tục sử dụng\ndịch vụ.",
                textTransfer: "Đi tới cài đặt vị trí >",
                settingAction: () {
                  perm.openAppSettings();
                },
                buttonTitle: "Xác nhận",
                acceptAction: () {
                }
              );
            }else{
              final result = await ticketSupplierUseCase.applyTicket(ticketId);
              result.fold(
                (left) => getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
                (right) => emit(state.copyWith(status: NewDetailsStatus.applySuccess)),
              );
            }
          },
        );
  }
}
