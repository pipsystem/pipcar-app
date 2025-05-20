import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/ui/customers/list_customers/list_customers_screen.dart';
import 'package:pipcar/features/ui/dispatch/dispatch/dispatch_provider.dart';
import 'package:pipcar/features/ui/schedule/my_schedule/my_accepted_schedule/details_my_accepted/my_accepted_details_screen.dart';
import '../../../features/domain/enterties/dispatch/driver_delivering_entity.dart';
import '../../../features/domain/enterties/entities.dart';
import '../../../features/ui/auth/login/login_screen.dart';
import '../../../features/ui/auth/term/term_page.dart';
import '../../../features/ui/create_navigate_ticket/add_navigate_ticket_screen.dart';
import '../../../features/ui/dash_board/dash_board.dart';

import '../../../features/ui/dash_board/menu/page/car/details_car/details_car_screen.dart';
import '../../../features/ui/dash_board/menu/page/car/list_car_screen.dart';
import '../../../features/ui/dash_board/menu/page/driver/list_driver_screen.dart';
import '../../../features/ui/dash_board/menu/menu_screen.dart';
import '../../../features/ui/dash_board/menu/page/profile/profile_screen.dart';
import '../../../features/ui/dash_board/menu/page/settings/agency_settings.dart';
import '../../../features/ui/dash_board/menu/page/transation/transaction_details/transaction_details_provider.dart';
import '../../../features/ui/dash_board/menu/page/transation/transaction_list/transaction_list_provider.dart';
import '../../../features/ui/dash_board/search/search_screen.dart';
import '../../../features/ui/dash_board/search/config/type_car_screen.dart';
import '../../../features/ui/dispatch/list_car_dispatch/list_dispatch_screen.dart';
import '../../../features/ui/dispatch/salary_month_statistic/salary_month_statistic_provider.dart';
import '../../../features/ui/dispatch/statistical/statistic_provider.dart';
import '../../../features/ui/schedule/my_schedule/my_complete_schedule/details_my_complete/my_complete_details_screen.dart';
import '../../../features/ui/schedule/my_schedule/my_drop_off_schedule/details_my_drop_off/my_drop_off_details_screen.dart';
import '../../../features/ui/schedule/my_schedule/my_schedule.dart';
import '../../../features/ui/schedule/pass_schedule/accepted_list/details_accepted/details_accepted_screen.dart';
import '../../../features/ui/schedule/pass_schedule/add_schedule/add_schedule_screen.dart';
import '../../../features/ui/schedule/pass_schedule/complete_list/details_complete/details_complete.dart';
import '../../../features/ui/schedule/pass_schedule/pass_list/details_pass/details_pass_screen.dart';
import '../../../features/ui/schedule/pass_schedule/pass_schedule_provider.dart';
import '../../../features/ui/schedule/system_schedule/enroll_schedule/details_my_enroll/my_enroll_details_screen.dart';
import '../../../features/ui/schedule/system_schedule/new_schedule/new_details.dart/new_details_screen.dart';
import '../../../features/ui/schedule/system_schedule/system_schedule.dart';
import '../../../features/ui/splash/splash.dart';
import '../../../features/ui/schedule/pass_schedule/process_list/details_process/details_process_screen.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Provider,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashPageRoute.page, path: Routes.splash),
        AutoRoute(page: LoginPageRoute.page, path: Routes.login),
        AutoRoute(page: TermPageRoute.page, path: Routes.term),
        AutoRoute(page: DashBoardPageRoute.page, path: Routes.dashBoard),
        AutoRoute(page: ListCarRoute.page, path: Routes.listCar),
        AutoRoute(page: ListDriverRoute.page, path: Routes.listDriver),
        AutoRoute(page: ListDispatchRoute.page, path: Routes.listDispatch),
        AutoRoute(page: ProfileRoute.page, path: Routes.profile),
        AutoRoute(page: SearchPageRoute.page, path: Routes.search),
        AutoRoute(page: TypeCarPageRoute.page, path: Routes.typeCar),
        AutoRoute(page: MenuPageRoute.page, path: Routes.menu),
        AutoRoute(page: DetailsCarPageRoute.page, path: Routes.detailsCar),
        AutoRoute(page: PassSchedulePageRoute.page, path: Routes.passSchedule),
        AutoRoute(page: AddSchedulePageRoute.page, path: Routes.addSchedule, fullscreenDialog: true),
        AutoRoute(page: DetailsPassPageRoute.page, path: Routes.detailsPass),
        AutoRoute(
            page: DetailsAcceptedPageRoute.page, path: Routes.detailsAccepted),
        AutoRoute(
            page: DetailsCompletePageRoute.page, path: Routes.detailsComplete),
        AutoRoute(page: AgencySettingsRoute.page, path: Routes.agencySettings),
        AutoRoute(
            page: SystemSchedulePageRoute.page, path: Routes.sytemSchedule),
        AutoRoute(page: MySchedulePageRoute.page, path: Routes.mySchedule),
        AutoRoute(page: NewDetailsPageRoute.page),
        AutoRoute(page: MyEnrollDetailsPageRoute.page),
        AutoRoute(page: MyAcceptedDetailsPageRoute.page),
        AutoRoute(page: MyDropOffDetailsPageRoute.page),
        AutoRoute(page: MyCompleteDetailsPageRoute.page),
        AutoRoute(page: TransactionListRoute.page),
        AutoRoute(page: TransactionDetailRoute.page),
        AutoRoute(page: DispatchPageRoute.page),
        AutoRoute(page: AddNavigatePageRoute.page),
        AutoRoute(page: ListCustomersRoute.page, path: Routes.listCustomers),
        AutoRoute(page: SalaryMonthStatisticRoute.page),
        AutoRoute(
            page: StatiticExpenseRoute.page, path: Routes.statiticExpense),
        AutoRoute(
            page: DetailsProcessPageRoute.page, path: Routes.statiticExpense),
      ];
}

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String term = '/term';
  static const String dashBoard = '/dashBoard';
  static const String listCar = '/listCar';
  static const String listDriver = '/list_driver';
  static const String listDispatch = '/list_dispatch';
  static const String profile = '/profile';
  static const String menu = '/menu';
  static const String search = '/search';
  static const String typeCar = '/typeCar';
  static const String detailsCar = '/details_car';
  static const String addSchedule = '/add_schedule';
  static const String passSchedule = '/pass_schedule';
  static const String detailsPass = '/details_pass';
  static const String detailsAccepted = '/details_accepted';
  static const String detailsComplete = '/details_accepted';
  static const String agencySettings = '/agency_settings';
  static const String sytemSchedule = '/sytem_schedule';
  static const String mySchedule = '/my_schedule';
  static const String listCustomers = '/list_customers';
  static const String statiticExpense = '/statitic_expense';
  static const String detailsProcess = '/statitic_process';
}
