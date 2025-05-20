// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../core/presentation/bloc/auth_bloc/auth_cubit.dart' as _i12;
import '../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart' as _i21;
import '../../core/presentation/bloc/internet_bloc/internet_cubit.dart' as _i27;
import '../../core/presentation/bloc/language_bloc/language_bloc.dart' as _i28;
import '../../core/presentation/bloc/loading_bloc/loading_bloc.dart' as _i32;
import '../../core/presentation/bloc/location_bloc/location_cubit.dart' as _i33;
import '../../core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart' as _i38;
import '../../core/presentation/routers/app_router.dart' as _i7;
import '../../features/data/repository/agency_repository_impl.dart' as _i5;
import '../../features/data/repository/athen_repository_impl.dart' as _i10;
import '../../features/data/repository/car_repository_impl.dart' as _i15;
import '../../features/data/repository/customers_repository_impl.dart' as _i19;
import '../../features/data/repository/driver_repository_impl.dart' as _i25;
import '../../features/data/repository/ticket_owner_repository_impl.dart'
    as _i42;
import '../../features/data/repository/ticket_supplier_repository_impl.dart'
    as _i46;
import '../../features/data/repository/transaction_repository_impl.dart'
    as _i50;
import '../../features/data/source/agency_remote_data_source.dart' as _i3;
import '../../features/data/source/authen_remote_data_source.dart' as _i8;
import '../../features/data/source/car_remote_data_source.dart' as _i13;
import '../../features/data/source/customer_remote_data_source.dart' as _i17;
import '../../features/data/source/driver_remote_data_source.dart' as _i23;
import '../../features/data/source/ticket_owner_remote_data_source.dart'
    as _i40;
import '../../features/data/source/ticket_supplier_remote_data_source.dart'
    as _i44;
import '../../features/data/source/transaction_remote_data_source.dart' as _i48;
import '../../features/domain/repository/agency_repository.dart' as _i4;
import '../../features/domain/repository/authen_repository.dart' as _i9;
import '../../features/domain/repository/car_repository.dart' as _i14;
import '../../features/domain/repository/customers_repository.dart' as _i18;
import '../../features/domain/repository/driver_repository.dart' as _i24;
import '../../features/domain/repository/ticket_owner_repository.dart' as _i41;
import '../../features/domain/repository/ticket_supplier_repository.dart'
    as _i45;
import '../../features/domain/repository/transaction_repository.dart' as _i49;
import '../../features/domain/use_case/agency_use_case.dart' as _i6;
import '../../features/domain/use_case/authen_use_case.dart' as _i11;
import '../../features/domain/use_case/car_use_case.dart' as _i16;
import '../../features/domain/use_case/customers_use_case.dart' as _i20;
import '../../features/domain/use_case/driver_use_case.dart' as _i26;
import '../../features/domain/use_case/ticket_owner_use_case.dart' as _i43;
import '../../features/domain/use_case/ticket_supplier_use_case.dart' as _i47;
import '../../features/domain/use_case/transaction_use_case.dart' as _i51;
import '../../features/ui/auth/login/cubit/login_cubit.dart' as _i34;
import '../../features/ui/create_navigate_ticket/cubit/add_navigate_ticket_cubit.dart'
    as _i53;
import '../../features/ui/customers/list_customers/cubit/list_customers_cubit.dart'
    as _i29;
import '../../features/ui/dash_board/home/cubit/home_cubit.dart' as _i64;
import '../../features/ui/dash_board/menu/cubit/menu_cubit.dart' as _i35;
import '../../features/ui/dash_board/menu/page/car/cubit/car_list_cubit.dart'
    as _i55;
import '../../features/ui/dash_board/menu/page/driver/cubit/list_driver_cubit.dart'
    as _i31;
import '../../features/ui/dash_board/menu/page/driver/delivery_car/cubit/delivery_car_cubit.dart'
    as _i57;
import '../../features/ui/dash_board/menu/page/transation/transaction_details/cubit/transaction_detail_cubit.dart'
    as _i76;
import '../../features/ui/dash_board/menu/page/transation/transaction_list/cubit/transaction_list_cubit.dart'
    as _i77;
import '../../features/ui/dash_board/search/cubit/search_cubit.dart' as _i37;
import '../../features/ui/dispatch/dispatch/cubit/dispatch_cubit.dart' as _i22;
import '../../features/ui/dispatch/list_car_dispatch/cubit/list_dispatch_cubit.dart'
    as _i30;
import '../../features/ui/dispatch/list_car_dispatch/detail_driver/cubit/details_driver_cubit.dart'
    as _i60;
import '../../features/ui/dispatch/salary_month_statistic/cubit/salary_month_statistic_cubit.dart'
    as _i36;
import '../../features/ui/dispatch/statistical/cubit/statistic_expense_cubit.dart'
    as _i39;
import '../../features/ui/schedule/my_schedule/my_accepted_schedule/cubit/my_accepted_schedule_cubit.dart'
    as _i66;
import '../../features/ui/schedule/my_schedule/my_accepted_schedule/details_my_accepted/cubit/my_accepted_details_cubit.dart'
    as _i65;
import '../../features/ui/schedule/my_schedule/my_complete_schedule/cubit/my_complete_schedule_cubit.dart'
    as _i68;
import '../../features/ui/schedule/my_schedule/my_complete_schedule/details_my_complete/cubit/my_complete_details_cubit.dart'
    as _i67;
import '../../features/ui/schedule/my_schedule/my_drop_off_schedule/cubit/my_drop_off_schedule_cubit.dart'
    as _i70;
import '../../features/ui/schedule/my_schedule/my_drop_off_schedule/details_my_drop_off/cubit/my_drop_off_details_cubit.dart'
    as _i69;
import '../../features/ui/schedule/pass_schedule/accepted_list/cubit/accepted_list_cubit.dart'
    as _i52;
import '../../features/ui/schedule/pass_schedule/accepted_list/details_accepted/cubit/details_accepted_cubit.dart'
    as _i58;
import '../../features/ui/schedule/pass_schedule/add_schedule/cubit/add_schedule_cubit.dart'
    as _i54;
import '../../features/ui/schedule/pass_schedule/complete_list/cubit/complete_list_cubit.dart'
    as _i56;
import '../../features/ui/schedule/pass_schedule/complete_list/details_complete/cubit/details_complete_cubit.dart'
    as _i59;
import '../../features/ui/schedule/pass_schedule/pass_list/cubit/pass_list_cubit.dart'
    as _i74;
import '../../features/ui/schedule/pass_schedule/pass_list/details_pass/cubit/details_pass_cubit.dart'
    as _i61;
import '../../features/ui/schedule/pass_schedule/process_list/cubit/process_list_cubit.dart'
    as _i75;
import '../../features/ui/schedule/pass_schedule/process_list/details_process/cubit/details_process_cubit.dart'
    as _i62;
import '../../features/ui/schedule/system_schedule/enroll_schedule/cubit/enroll_schedule_cubit.dart'
    as _i63;
import '../../features/ui/schedule/system_schedule/enroll_schedule/details_my_enroll/cubit/my_enroll_details_cubit.dart'
    as _i71;
import '../../features/ui/schedule/system_schedule/new_schedule/cubit/new_schedule_cubit.dart'
    as _i73;
import '../../features/ui/schedule/system_schedule/new_schedule/new_details.dart/cubit/new_details_cubit.dart'
    as _i72;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AgencyRemoteDataSource>(
        () => _i3.AgencyRemoteDataSourceImpl());
    gh.factory<_i4.AgencyRepository>(
        () => _i5.AgencyRepositoryImpl(gh<_i3.AgencyRemoteDataSource>()));
    gh.factory<_i6.AgencyUseCase>(
        () => _i6.AgencyUseCase(gh<_i4.AgencyRepository>()));
    gh.lazySingleton<_i7.AppRouter>(() => _i7.AppRouter());
    gh.factory<_i8.AuthenRemoteDataSource>(
        () => _i8.AuthenRemoteDataSourceImpl());
    gh.factory<_i9.AuthenRepository>(
        () => _i10.AuthenRepositoryImpl(gh<_i8.AuthenRemoteDataSource>()));
    gh.factory<_i11.AuthenUseCase>(
        () => _i11.AuthenUseCase(gh<_i9.AuthenRepository>()));
    gh.lazySingleton<_i12.AuthenticationCubit>(() => _i12.AuthenticationCubit(
          gh<_i11.AuthenUseCase>(),
          gh<_i6.AgencyUseCase>(),
        ));
    gh.factory<_i13.CarRemoteDataSource>(() => _i13.CarRemoteDataSourceImpl());
    gh.factory<_i14.CarRepository>(
        () => _i15.CarRepositoryImpl(gh<_i13.CarRemoteDataSource>()));
    gh.factory<_i16.CarUseCase>(
        () => _i16.CarUseCase(gh<_i14.CarRepository>()));
    gh.factory<_i17.CustomerRemoteDataSource>(
        () => _i17.CustomerRemoteDataSourceImpl());
    gh.factory<_i18.CustomersRepository>(() =>
        _i19.CustomersRepositoryImpl(gh<_i17.CustomerRemoteDataSource>()));
    gh.factory<_i20.CustomersUseCase>(
        () => _i20.CustomersUseCase(gh<_i18.CustomersRepository>()));
    gh.lazySingleton<_i21.DialogBloc>(() => _i21.DialogBloc());
    gh.factory<_i22.DispatchCubit>(
        () => _i22.DispatchCubit(gh<_i6.AgencyUseCase>()));
    gh.factory<_i23.DriverRemoteDataSource>(
        () => _i23.DriverRemoteDataSourceImpl());
    gh.factory<_i24.DriverRepository>(
        () => _i25.DriverRepositoryImpl(gh<_i23.DriverRemoteDataSource>()));
    gh.factory<_i26.DriverUseCase>(
        () => _i26.DriverUseCase(gh<_i24.DriverRepository>()));
    gh.factory<_i27.InternetCubit>(() => _i27.InternetCubit());
    gh.lazySingleton<_i28.LanguageBloc>(() => _i28.LanguageBloc());
    gh.factory<_i29.ListCustomersCubit>(
        () => _i29.ListCustomersCubit(gh<_i20.CustomersUseCase>()));
    gh.factory<_i30.ListDispatchCubit>(() => _i30.ListDispatchCubit(
          gh<_i26.DriverUseCase>(),
          gh<_i16.CarUseCase>(),
          gh<_i6.AgencyUseCase>(),
        ));
    gh.factory<_i31.ListDriverCubit>(() => _i31.ListDriverCubit(
          gh<_i26.DriverUseCase>(),
          gh<_i6.AgencyUseCase>(),
        ));
    gh.lazySingleton<_i32.LoadingBloc>(() => _i32.LoadingBloc());
    gh.factory<_i33.LocationCubit>(() => _i33.LocationCubit());
    gh.factory<_i34.LoginCubit>(
        () => _i34.LoginCubit(gh<_i11.AuthenUseCase>()));
    gh.factory<_i35.MenuCubit>(() => _i35.MenuCubit(gh<_i6.AgencyUseCase>()));
    gh.factory<_i36.SalaryMonthStatisticCubit>(
        () => _i36.SalaryMonthStatisticCubit(gh<_i6.AgencyUseCase>()));
    gh.factory<_i37.SearchCubit>(
        () => _i37.SearchCubit(gh<_i6.AgencyUseCase>()));
    gh.lazySingleton<_i38.SnackbarBloc>(() => _i38.SnackbarBloc());
    gh.factory<_i39.StatisticExpenseCubit>(
        () => _i39.StatisticExpenseCubit(gh<_i6.AgencyUseCase>()));
    gh.factory<_i40.TicketOwnerRemoteDataSource>(
        () => _i40.TicketOwnerDataSourceImpl());
    gh.factory<_i41.TicketOwnerRepository>(() =>
        _i42.TicketOwnerRepositoryImpl(gh<_i40.TicketOwnerRemoteDataSource>()));
    gh.factory<_i43.TicketOwnerUseCase>(
        () => _i43.TicketOwnerUseCase(gh<_i41.TicketOwnerRepository>()));
    gh.factory<_i44.TicketSupplierRemoteDataSource>(
        () => _i44.TicketSupplierDataSourceImpl());
    gh.factory<_i45.TicketSupplierRepository>(() =>
        _i46.TicketSupplierRepositoryImpl(
            gh<_i44.TicketSupplierRemoteDataSource>()));
    gh.factory<_i47.TicketSupplierUseCase>(
        () => _i47.TicketSupplierUseCase(gh<_i45.TicketSupplierRepository>()));
    gh.factory<_i48.TransactionRemoteDataSource>(
        () => _i48.TransactionRemoteDataSourceImpl());
    gh.factory<_i49.TransactionRepository>(() =>
        _i50.TransactionRepositoryImpl(gh<_i48.TransactionRemoteDataSource>()));
    gh.factory<_i51.TransactionUseCase>(
        () => _i51.TransactionUseCase(gh<_i49.TransactionRepository>()));
    gh.factory<_i52.AcceptedListCubit>(
        () => _i52.AcceptedListCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i53.AddNavigateTicketCubit>(() => _i53.AddNavigateTicketCubit(
          gh<_i43.TicketOwnerUseCase>(),
          gh<_i6.AgencyUseCase>(),
        ));
    gh.factory<_i54.AddScheduleCubit>(() => _i54.AddScheduleCubit(
          gh<_i43.TicketOwnerUseCase>(),
          gh<_i6.AgencyUseCase>(),
        ));
    gh.factory<_i55.CarListCubit>(
        () => _i55.CarListCubit(gh<_i16.CarUseCase>()));
    gh.factory<_i56.CompleteListCubit>(
        () => _i56.CompleteListCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i57.DeliveryCarCubit>(() => _i57.DeliveryCarCubit(
          gh<_i26.DriverUseCase>(),
          gh<_i16.CarUseCase>(),
        ));
    gh.factory<_i58.DetailsAcceptedCubit>(
        () => _i58.DetailsAcceptedCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i59.DetailsCompleteCubit>(
        () => _i59.DetailsCompleteCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i60.DetailsDriverCubit>(() => _i60.DetailsDriverCubit(
          gh<_i6.AgencyUseCase>(),
          gh<_i26.DriverUseCase>(),
        ));
    gh.factory<_i61.DetailsPassCubit>(
        () => _i61.DetailsPassCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i62.DetailsProcessCubit>(
        () => _i62.DetailsProcessCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i63.EnrollScheduleCubit>(
        () => _i63.EnrollScheduleCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i64.HomeCubit>(() => _i64.HomeCubit(
          gh<_i6.AgencyUseCase>(),
          gh<_i47.TicketSupplierUseCase>(),
        ));
    gh.factory<_i65.MyAcceptedDetailsCubit>(
        () => _i65.MyAcceptedDetailsCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i66.MyAcceptedScheduleCubit>(
        () => _i66.MyAcceptedScheduleCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i67.MyCompleteDetailsCubit>(
        () => _i67.MyCompleteDetailsCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i68.MyCompleteScheduleCubit>(
        () => _i68.MyCompleteScheduleCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i69.MyDropOffDetailsCubit>(
        () => _i69.MyDropOffDetailsCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i70.MyDropOffScheduleCubit>(
        () => _i70.MyDropOffScheduleCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i71.MyEnrollDetailsCubit>(
        () => _i71.MyEnrollDetailsCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i72.NewDetailsCubit>(
        () => _i72.NewDetailsCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i73.NewScheduleCubit>(
        () => _i73.NewScheduleCubit(gh<_i47.TicketSupplierUseCase>()));
    gh.factory<_i74.PassListCubit>(
        () => _i74.PassListCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i75.ProcessListCubit>(
        () => _i75.ProcessListCubit(gh<_i43.TicketOwnerUseCase>()));
    gh.factory<_i76.TransactionDetailCubit>(
        () => _i76.TransactionDetailCubit(gh<_i51.TransactionUseCase>()));
    gh.factory<_i77.TransactionListCubit>(
        () => _i77.TransactionListCubit(gh<_i51.TransactionUseCase>()));
    return this;
  }
}
