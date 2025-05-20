import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';

import 'package:pipcar/features/ui/dash_board/home/home_screen.dart';
import 'package:pipcar/features/ui/dash_board/menu/menu_screen.dart';

import '../../../common/di/di.dart';
import '../../../core/presentation/widgets/widgets.dart';
import 'bottom_navigate.dart';

@RoutePage()
class DashBoardPageProvider extends StatefulWidget {
  const DashBoardPageProvider({Key? key}) : super(key: key);

  @override
  State<DashBoardPageProvider> createState() => _DashBoardPageProviderState();
}

class _DashBoardPageProviderState extends State<DashBoardPageProvider>
    with TickerProviderStateMixin {
  late TabController tabController;
  DateTime? currentBackPressTime;
  List<Widget> listTab = const [
    HomeScreen(),
    SizedBox(),
    MenuPageProvider(),
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    tabController = TabController(vsync: this, length: 3);
    // context.read<AuthenticationCubit>().updateDeviceId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      handleNotiFromTerminate();
    });
    super.initState();
  }

  void handleNotiFromTerminate() {
    if (isNullEmpty(LocalStorage.payloadNotify.val)) return;
    final Map<String, dynamic> payload =
        jsonDecode(LocalStorage.payloadNotify.val);
    final router =
        getIt.get<AppRouter>().navigatorKey.currentState!.context.router;
    switch (payload['action_type'].toString()) {
      case '1':
        if (payload['id'] != null) {
          router.push(NewDetailsPageRoute(ticketId: payload['id']));
        }
        break;
      case '2':
        router.pushNamed(Routes.sytemSchedule);
        break;
      case '3':
        if (payload['id'] != null) {
          router.push(MyAcceptedDetailsPageRoute(ticketId: payload['id']));
        }
        break;
      case '4':
        if (payload['id'] != null) {
          router.push(MyAcceptedDetailsPageRoute(ticketId: payload['id']));
        }
        break;
      case '5':
        if (payload['id'] != null) {
          router.push(MyCompleteDetailsPageRoute(ticketId: payload['id']));
        }
        break;
      case '6':
        if (payload['id'] != null) {
          router.push(DetailsPassPageRoute(ticketId: payload['id']));
        }
        break;
      case '7':
        if (payload['id'] != null) {
          router.push(DetailsAcceptedPageRoute(ticketId: payload['id']));
        }
        break;
      default:
    }
    LocalStorage.payloadNotify.val = '';
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: Column(
          children: [
            DefaultTabController(
              length: 3,
              child: Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: listTab,
                ),
              ),
            ),
            BottomNavigationBarWidget(
              tabController: tabController,
            ),
          ],
        ),
      ),
    );
  }
}
