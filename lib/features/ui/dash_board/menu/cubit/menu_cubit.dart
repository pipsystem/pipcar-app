import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import 'package:pipcar/core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_infor_entity.dart';
import 'package:pipcar/features/domain/use_case/agency_use_case.dart';

part 'menu_state.dart';

@injectable
class MenuCubit extends BaseBloc<MenuState> {
  final AgencyUseCase agencyUseCase;
  MenuCubit(this.agencyUseCase) : super(MenuState.initial());

  @override
  void onInit() async {
    final result = await agencyUseCase.getAgencyInfor();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
            state.copyWith(status: MenuStatus.loaded, agencyInfor: right)));
  }

  Future<void> getAgencyInfor() async {
    emit(state.copyWith(status: MenuStatus.loading));
    final result = await agencyUseCase.getAgencyInfor();
    result.fold(
        (left) =>
            getIt.get<DialogBloc>().showAlertDialog(message: left.toString()),
        (right) => emit(
            state.copyWith(status: MenuStatus.loaded, agencyInfor: right)));
  }

  Future<void> blockAccount() async {
    getIt.get<DialogBloc>().showOptionDialog(
        message: "Bạn chắc chắn muốn xóa tài khoản này khỏi hệ thống Pipcar?",
        acceptAction: () async {
          final result = await agencyUseCase.blockAccount();
          result.fold(
              (left) => getIt
                  .get<DialogBloc>()
                  .showAlertDialog(message: left.toString()), (right) {
            LocalStorage.clearToken();
            getIt.get<SnackbarBloc>().showSnackbar(
                translationKey: "Xóa tài khoản thành công",
                type: SnackBarType.success);
            getIt
                .get<AuthenticationCubit>()
                .emit(const AuthenticationState.unauthenticated());
          });
        });
  }
}
