// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ListCustomersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListCustomersProvider(),
      );
    },
    SplashPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPageProvider(),
      );
    },
    NewDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<NewDetailsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewDetailsPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    SystemSchedulePageRoute.name: (routeData) {
      final args = routeData.argsAs<SystemSchedulePageRouteArgs>(
          orElse: () => const SystemSchedulePageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SystemSchedulePageProvider(
          key: args.key,
          driver: args.driver,
          initialPage: args.initialPage,
        ),
      );
    },
    MyEnrollDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<MyEnrollDetailsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyEnrollDetailsPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    MySchedulePageRoute.name: (routeData) {
      final args = routeData.argsAs<MySchedulePageRouteArgs>(
          orElse: () => const MySchedulePageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MySchedulePageProvider(
          key: args.key,
          driver: args.driver,
          initialPage: args.initialPage,
        ),
      );
    },
    MyCompleteDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<MyCompleteDetailsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyCompleteDetailsPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    MyAcceptedDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<MyAcceptedDetailsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyAcceptedDetailsPageProvider(
          key: args.key,
          driver: args.driver,
          ticketId: args.ticketId,
        ),
      );
    },
    MyDropOffDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<MyDropOffDetailsPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyDropOffDetailsPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    AddSchedulePageRoute.name: (routeData) {
      final args = routeData.argsAs<AddSchedulePageRouteArgs>(
          orElse: () => const AddSchedulePageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddSchedulePageProvider(
          key: args.key,
          ticketDetails: args.ticketDetails,
          isPassAgain: args.isPassAgain,
        ),
      );
    },
    DetailsAcceptedPageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsAcceptedPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsAcceptedPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    PassSchedulePageRoute.name: (routeData) {
      final args = routeData.argsAs<PassSchedulePageRouteArgs>(
          orElse: () => const PassSchedulePageRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PassSchedulePageProvider(
          key: args.key,
          initialPage: args.initialPage,
        ),
      );
    },
    DetailsProcessPageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsProcessPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsProcessPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    DetailsCompletePageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsCompletePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsCompletePageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    DetailsPassPageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsPassPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsPassPageProvider(
          key: args.key,
          ticketId: args.ticketId,
        ),
      );
    },
    TermPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TermPageProvider(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPageProvider(),
      );
    },
    ListDispatchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListDispatchProvider(),
      );
    },
    DispatchPageRoute.name: (routeData) {
      final args = routeData.argsAs<DispatchPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DispatchPageProvider(
          key: args.key,
          driver: args.driver,
        ),
      );
    },
    StatiticExpenseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StatiticExpenseProvider(),
      );
    },
    SalaryMonthStatisticRoute.name: (routeData) {
      final args = routeData.argsAs<SalaryMonthStatisticRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SalaryMonthStatisticProvider(
          key: args.key,
          supplierId: args.supplierId,
        ),
      );
    },
    TypeCarPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TypeCarPageProvider(),
      );
    },
    SearchPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchPageProvider(),
      );
    },
    AgencySettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AgencySettingsProvider(),
      );
    },
    ListCarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListCarProvider(),
      );
    },
    DetailsCarPageRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsCarPageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailsCarPageProvider(
          key: args.key,
          car: args.car,
        ),
      );
    },
    ListDriverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ListDriverProvider(),
      );
    },
    ProfileRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileProvider(
          key: args.key,
          agency: args.agency,
        ),
      );
    },
    TransactionListRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionListProvider(
          key: args.key,
          currentCoin: args.currentCoin,
        ),
      );
    },
    TransactionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TransactionDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TransactionDetailProvider(
          key: args.key,
          transactionId: args.transactionId,
        ),
      );
    },
    MenuPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MenuPageProvider(),
      );
    },
    DashBoardPageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashBoardPageProvider(),
      );
    },
    AddNavigatePageRoute.name: (routeData) {
      final args = routeData.argsAs<AddNavigatePageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddNavigatePageProvider(
          key: args.key,
          supplierId: args.supplierId,
          carTypeId: args.carTypeId,
        ),
      );
    },
  };
}

/// generated route for
/// [ListCustomersProvider]
class ListCustomersRoute extends PageRouteInfo<void> {
  const ListCustomersRoute({List<PageRouteInfo>? children})
      : super(
          ListCustomersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListCustomersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPageProvider]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute({List<PageRouteInfo>? children})
      : super(
          SplashPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewDetailsPageProvider]
class NewDetailsPageRoute extends PageRouteInfo<NewDetailsPageRouteArgs> {
  NewDetailsPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          NewDetailsPageRoute.name,
          args: NewDetailsPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'NewDetailsPageRoute';

  static const PageInfo<NewDetailsPageRouteArgs> page =
      PageInfo<NewDetailsPageRouteArgs>(name);
}

class NewDetailsPageRouteArgs {
  const NewDetailsPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'NewDetailsPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [SystemSchedulePageProvider]
class SystemSchedulePageRoute
    extends PageRouteInfo<SystemSchedulePageRouteArgs> {
  SystemSchedulePageRoute({
    Key? key,
    DriverDeleveringEntity? driver,
    int? initialPage,
    List<PageRouteInfo>? children,
  }) : super(
          SystemSchedulePageRoute.name,
          args: SystemSchedulePageRouteArgs(
            key: key,
            driver: driver,
            initialPage: initialPage,
          ),
          initialChildren: children,
        );

  static const String name = 'SystemSchedulePageRoute';

  static const PageInfo<SystemSchedulePageRouteArgs> page =
      PageInfo<SystemSchedulePageRouteArgs>(name);
}

class SystemSchedulePageRouteArgs {
  const SystemSchedulePageRouteArgs({
    this.key,
    this.driver,
    this.initialPage,
  });

  final Key? key;

  final DriverDeleveringEntity? driver;

  final int? initialPage;

  @override
  String toString() {
    return 'SystemSchedulePageRouteArgs{key: $key, driver: $driver, initialPage: $initialPage}';
  }
}

/// generated route for
/// [MyEnrollDetailsPageProvider]
class MyEnrollDetailsPageRoute
    extends PageRouteInfo<MyEnrollDetailsPageRouteArgs> {
  MyEnrollDetailsPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          MyEnrollDetailsPageRoute.name,
          args: MyEnrollDetailsPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'MyEnrollDetailsPageRoute';

  static const PageInfo<MyEnrollDetailsPageRouteArgs> page =
      PageInfo<MyEnrollDetailsPageRouteArgs>(name);
}

class MyEnrollDetailsPageRouteArgs {
  const MyEnrollDetailsPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'MyEnrollDetailsPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [MySchedulePageProvider]
class MySchedulePageRoute extends PageRouteInfo<MySchedulePageRouteArgs> {
  MySchedulePageRoute({
    Key? key,
    DriverDeleveringEntity? driver,
    int? initialPage,
    List<PageRouteInfo>? children,
  }) : super(
          MySchedulePageRoute.name,
          args: MySchedulePageRouteArgs(
            key: key,
            driver: driver,
            initialPage: initialPage,
          ),
          initialChildren: children,
        );

  static const String name = 'MySchedulePageRoute';

  static const PageInfo<MySchedulePageRouteArgs> page =
      PageInfo<MySchedulePageRouteArgs>(name);
}

class MySchedulePageRouteArgs {
  const MySchedulePageRouteArgs({
    this.key,
    this.driver,
    this.initialPage,
  });

  final Key? key;

  final DriverDeleveringEntity? driver;

  final int? initialPage;

  @override
  String toString() {
    return 'MySchedulePageRouteArgs{key: $key, driver: $driver, initialPage: $initialPage}';
  }
}

/// generated route for
/// [MyCompleteDetailsPageProvider]
class MyCompleteDetailsPageRoute
    extends PageRouteInfo<MyCompleteDetailsPageRouteArgs> {
  MyCompleteDetailsPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          MyCompleteDetailsPageRoute.name,
          args: MyCompleteDetailsPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'MyCompleteDetailsPageRoute';

  static const PageInfo<MyCompleteDetailsPageRouteArgs> page =
      PageInfo<MyCompleteDetailsPageRouteArgs>(name);
}

class MyCompleteDetailsPageRouteArgs {
  const MyCompleteDetailsPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'MyCompleteDetailsPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [MyAcceptedDetailsPageProvider]
class MyAcceptedDetailsPageRoute
    extends PageRouteInfo<MyAcceptedDetailsPageRouteArgs> {
  MyAcceptedDetailsPageRoute({
    Key? key,
    DriverDeleveringEntity? driver,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          MyAcceptedDetailsPageRoute.name,
          args: MyAcceptedDetailsPageRouteArgs(
            key: key,
            driver: driver,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'MyAcceptedDetailsPageRoute';

  static const PageInfo<MyAcceptedDetailsPageRouteArgs> page =
      PageInfo<MyAcceptedDetailsPageRouteArgs>(name);
}

class MyAcceptedDetailsPageRouteArgs {
  const MyAcceptedDetailsPageRouteArgs({
    this.key,
    this.driver,
    required this.ticketId,
  });

  final Key? key;

  final DriverDeleveringEntity? driver;

  final String ticketId;

  @override
  String toString() {
    return 'MyAcceptedDetailsPageRouteArgs{key: $key, driver: $driver, ticketId: $ticketId}';
  }
}

/// generated route for
/// [MyDropOffDetailsPageProvider]
class MyDropOffDetailsPageRoute
    extends PageRouteInfo<MyDropOffDetailsPageRouteArgs> {
  MyDropOffDetailsPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          MyDropOffDetailsPageRoute.name,
          args: MyDropOffDetailsPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'MyDropOffDetailsPageRoute';

  static const PageInfo<MyDropOffDetailsPageRouteArgs> page =
      PageInfo<MyDropOffDetailsPageRouteArgs>(name);
}

class MyDropOffDetailsPageRouteArgs {
  const MyDropOffDetailsPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'MyDropOffDetailsPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [AddSchedulePageProvider]
class AddSchedulePageRoute extends PageRouteInfo<AddSchedulePageRouteArgs> {
  AddSchedulePageRoute({
    Key? key,
    DetailsPassTicket? ticketDetails,
    bool? isPassAgain,
    List<PageRouteInfo>? children,
  }) : super(
          AddSchedulePageRoute.name,
          args: AddSchedulePageRouteArgs(
            key: key,
            ticketDetails: ticketDetails,
            isPassAgain: isPassAgain,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSchedulePageRoute';

  static const PageInfo<AddSchedulePageRouteArgs> page =
      PageInfo<AddSchedulePageRouteArgs>(name);
}

class AddSchedulePageRouteArgs {
  const AddSchedulePageRouteArgs({
    this.key,
    this.ticketDetails,
    this.isPassAgain,
  });

  final Key? key;

  final DetailsPassTicket? ticketDetails;

  final bool? isPassAgain;

  @override
  String toString() {
    return 'AddSchedulePageRouteArgs{key: $key, ticketDetails: $ticketDetails, isPassAgain: $isPassAgain}';
  }
}

/// generated route for
/// [DetailsAcceptedPageProvider]
class DetailsAcceptedPageRoute
    extends PageRouteInfo<DetailsAcceptedPageRouteArgs> {
  DetailsAcceptedPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsAcceptedPageRoute.name,
          args: DetailsAcceptedPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsAcceptedPageRoute';

  static const PageInfo<DetailsAcceptedPageRouteArgs> page =
      PageInfo<DetailsAcceptedPageRouteArgs>(name);
}

class DetailsAcceptedPageRouteArgs {
  const DetailsAcceptedPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'DetailsAcceptedPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [PassSchedulePageProvider]
class PassSchedulePageRoute extends PageRouteInfo<PassSchedulePageRouteArgs> {
  PassSchedulePageRoute({
    Key? key,
    int? initialPage,
    List<PageRouteInfo>? children,
  }) : super(
          PassSchedulePageRoute.name,
          args: PassSchedulePageRouteArgs(
            key: key,
            initialPage: initialPage,
          ),
          initialChildren: children,
        );

  static const String name = 'PassSchedulePageRoute';

  static const PageInfo<PassSchedulePageRouteArgs> page =
      PageInfo<PassSchedulePageRouteArgs>(name);
}

class PassSchedulePageRouteArgs {
  const PassSchedulePageRouteArgs({
    this.key,
    this.initialPage,
  });

  final Key? key;

  final int? initialPage;

  @override
  String toString() {
    return 'PassSchedulePageRouteArgs{key: $key, initialPage: $initialPage}';
  }
}

/// generated route for
/// [DetailsProcessPageProvider]
class DetailsProcessPageRoute
    extends PageRouteInfo<DetailsProcessPageRouteArgs> {
  DetailsProcessPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsProcessPageRoute.name,
          args: DetailsProcessPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsProcessPageRoute';

  static const PageInfo<DetailsProcessPageRouteArgs> page =
      PageInfo<DetailsProcessPageRouteArgs>(name);
}

class DetailsProcessPageRouteArgs {
  const DetailsProcessPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'DetailsProcessPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [DetailsCompletePageProvider]
class DetailsCompletePageRoute
    extends PageRouteInfo<DetailsCompletePageRouteArgs> {
  DetailsCompletePageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsCompletePageRoute.name,
          args: DetailsCompletePageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsCompletePageRoute';

  static const PageInfo<DetailsCompletePageRouteArgs> page =
      PageInfo<DetailsCompletePageRouteArgs>(name);
}

class DetailsCompletePageRouteArgs {
  const DetailsCompletePageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'DetailsCompletePageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [DetailsPassPageProvider]
class DetailsPassPageRoute extends PageRouteInfo<DetailsPassPageRouteArgs> {
  DetailsPassPageRoute({
    Key? key,
    required String ticketId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsPassPageRoute.name,
          args: DetailsPassPageRouteArgs(
            key: key,
            ticketId: ticketId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsPassPageRoute';

  static const PageInfo<DetailsPassPageRouteArgs> page =
      PageInfo<DetailsPassPageRouteArgs>(name);
}

class DetailsPassPageRouteArgs {
  const DetailsPassPageRouteArgs({
    this.key,
    required this.ticketId,
  });

  final Key? key;

  final String ticketId;

  @override
  String toString() {
    return 'DetailsPassPageRouteArgs{key: $key, ticketId: $ticketId}';
  }
}

/// generated route for
/// [TermPageProvider]
class TermPageRoute extends PageRouteInfo<void> {
  const TermPageRoute({List<PageRouteInfo>? children})
      : super(
          TermPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPageProvider]
class LoginPageRoute extends PageRouteInfo<void> {
  const LoginPageRoute({List<PageRouteInfo>? children})
      : super(
          LoginPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ListDispatchProvider]
class ListDispatchRoute extends PageRouteInfo<void> {
  const ListDispatchRoute({List<PageRouteInfo>? children})
      : super(
          ListDispatchRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListDispatchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DispatchPageProvider]
class DispatchPageRoute extends PageRouteInfo<DispatchPageRouteArgs> {
  DispatchPageRoute({
    Key? key,
    required DriverDeleveringEntity driver,
    List<PageRouteInfo>? children,
  }) : super(
          DispatchPageRoute.name,
          args: DispatchPageRouteArgs(
            key: key,
            driver: driver,
          ),
          initialChildren: children,
        );

  static const String name = 'DispatchPageRoute';

  static const PageInfo<DispatchPageRouteArgs> page =
      PageInfo<DispatchPageRouteArgs>(name);
}

class DispatchPageRouteArgs {
  const DispatchPageRouteArgs({
    this.key,
    required this.driver,
  });

  final Key? key;

  final DriverDeleveringEntity driver;

  @override
  String toString() {
    return 'DispatchPageRouteArgs{key: $key, driver: $driver}';
  }
}

/// generated route for
/// [StatiticExpenseProvider]
class StatiticExpenseRoute extends PageRouteInfo<void> {
  const StatiticExpenseRoute({List<PageRouteInfo>? children})
      : super(
          StatiticExpenseRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatiticExpenseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SalaryMonthStatisticProvider]
class SalaryMonthStatisticRoute
    extends PageRouteInfo<SalaryMonthStatisticRouteArgs> {
  SalaryMonthStatisticRoute({
    Key? key,
    required String supplierId,
    List<PageRouteInfo>? children,
  }) : super(
          SalaryMonthStatisticRoute.name,
          args: SalaryMonthStatisticRouteArgs(
            key: key,
            supplierId: supplierId,
          ),
          initialChildren: children,
        );

  static const String name = 'SalaryMonthStatisticRoute';

  static const PageInfo<SalaryMonthStatisticRouteArgs> page =
      PageInfo<SalaryMonthStatisticRouteArgs>(name);
}

class SalaryMonthStatisticRouteArgs {
  const SalaryMonthStatisticRouteArgs({
    this.key,
    required this.supplierId,
  });

  final Key? key;

  final String supplierId;

  @override
  String toString() {
    return 'SalaryMonthStatisticRouteArgs{key: $key, supplierId: $supplierId}';
  }
}

/// generated route for
/// [TypeCarPageProvider]
class TypeCarPageRoute extends PageRouteInfo<void> {
  const TypeCarPageRoute({List<PageRouteInfo>? children})
      : super(
          TypeCarPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'TypeCarPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchPageProvider]
class SearchPageRoute extends PageRouteInfo<void> {
  const SearchPageRoute({List<PageRouteInfo>? children})
      : super(
          SearchPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AgencySettingsProvider]
class AgencySettingsRoute extends PageRouteInfo<void> {
  const AgencySettingsRoute({List<PageRouteInfo>? children})
      : super(
          AgencySettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AgencySettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ListCarProvider]
class ListCarRoute extends PageRouteInfo<void> {
  const ListCarRoute({List<PageRouteInfo>? children})
      : super(
          ListCarRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListCarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailsCarPageProvider]
class DetailsCarPageRoute extends PageRouteInfo<DetailsCarPageRouteArgs> {
  DetailsCarPageRoute({
    Key? key,
    required CarEntity car,
    List<PageRouteInfo>? children,
  }) : super(
          DetailsCarPageRoute.name,
          args: DetailsCarPageRouteArgs(
            key: key,
            car: car,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailsCarPageRoute';

  static const PageInfo<DetailsCarPageRouteArgs> page =
      PageInfo<DetailsCarPageRouteArgs>(name);
}

class DetailsCarPageRouteArgs {
  const DetailsCarPageRouteArgs({
    this.key,
    required this.car,
  });

  final Key? key;

  final CarEntity car;

  @override
  String toString() {
    return 'DetailsCarPageRouteArgs{key: $key, car: $car}';
  }
}

/// generated route for
/// [ListDriverProvider]
class ListDriverRoute extends PageRouteInfo<void> {
  const ListDriverRoute({List<PageRouteInfo>? children})
      : super(
          ListDriverRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListDriverRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileProvider]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    Key? key,
    required AgencyInforEntity agency,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRoute.name,
          args: ProfileRouteArgs(
            key: key,
            agency: agency,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<ProfileRouteArgs> page =
      PageInfo<ProfileRouteArgs>(name);
}

class ProfileRouteArgs {
  const ProfileRouteArgs({
    this.key,
    required this.agency,
  });

  final Key? key;

  final AgencyInforEntity agency;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, agency: $agency}';
  }
}

/// generated route for
/// [TransactionListProvider]
class TransactionListRoute extends PageRouteInfo<TransactionListRouteArgs> {
  TransactionListRoute({
    Key? key,
    required int currentCoin,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionListRoute.name,
          args: TransactionListRouteArgs(
            key: key,
            currentCoin: currentCoin,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionListRoute';

  static const PageInfo<TransactionListRouteArgs> page =
      PageInfo<TransactionListRouteArgs>(name);
}

class TransactionListRouteArgs {
  const TransactionListRouteArgs({
    this.key,
    required this.currentCoin,
  });

  final Key? key;

  final int currentCoin;

  @override
  String toString() {
    return 'TransactionListRouteArgs{key: $key, currentCoin: $currentCoin}';
  }
}

/// generated route for
/// [TransactionDetailProvider]
class TransactionDetailRoute extends PageRouteInfo<TransactionDetailRouteArgs> {
  TransactionDetailRoute({
    Key? key,
    required String transactionId,
    List<PageRouteInfo>? children,
  }) : super(
          TransactionDetailRoute.name,
          args: TransactionDetailRouteArgs(
            key: key,
            transactionId: transactionId,
          ),
          initialChildren: children,
        );

  static const String name = 'TransactionDetailRoute';

  static const PageInfo<TransactionDetailRouteArgs> page =
      PageInfo<TransactionDetailRouteArgs>(name);
}

class TransactionDetailRouteArgs {
  const TransactionDetailRouteArgs({
    this.key,
    required this.transactionId,
  });

  final Key? key;

  final String transactionId;

  @override
  String toString() {
    return 'TransactionDetailRouteArgs{key: $key, transactionId: $transactionId}';
  }
}

/// generated route for
/// [MenuPageProvider]
class MenuPageRoute extends PageRouteInfo<void> {
  const MenuPageRoute({List<PageRouteInfo>? children})
      : super(
          MenuPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashBoardPageProvider]
class DashBoardPageRoute extends PageRouteInfo<void> {
  const DashBoardPageRoute({List<PageRouteInfo>? children})
      : super(
          DashBoardPageRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashBoardPageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddNavigatePageProvider]
class AddNavigatePageRoute extends PageRouteInfo<AddNavigatePageRouteArgs> {
  AddNavigatePageRoute({
    Key? key,
    required String supplierId,
    int? carTypeId,
    List<PageRouteInfo>? children,
  }) : super(
          AddNavigatePageRoute.name,
          args: AddNavigatePageRouteArgs(
            key: key,
            supplierId: supplierId,
            carTypeId: carTypeId,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNavigatePageRoute';

  static const PageInfo<AddNavigatePageRouteArgs> page =
      PageInfo<AddNavigatePageRouteArgs>(name);
}

class AddNavigatePageRouteArgs {
  const AddNavigatePageRouteArgs({
    this.key,
    required this.supplierId,
    this.carTypeId,
  });

  final Key? key;

  final String supplierId;

  final int? carTypeId;

  @override
  String toString() {
    return 'AddNavigatePageRouteArgs{key: $key, supplierId: $supplierId, carTypeId: $carTypeId}';
  }
}
