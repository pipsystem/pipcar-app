import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/bloc/internet_bloc/internet_cubit.dart';
import '../../../common/configs/constants/app_dimens.dart';
import '../../../common/di/di.dart';
import '../../../common/mixins/dialogs_mixin.dart';
import '../../../common/themes/theme_data.dart';
import '../bloc/dialog_bloc/dialog_bloc.dart';
import '../bloc/language_bloc/language_bloc.dart';
import '../bloc/loading_bloc/loading_bloc.dart';
import '../bloc/location_bloc/location_cubit.dart';
import '../bloc/snackbar_bloc/snackbar_bloc.dart';
import '../routers/app_router.dart';
import '../widgets/loading_widget/loading_container_widget.dart';
import '../widgets/snackbar_widget/snackbar_widget.dart';
import 'dart:developer' as developer;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with DialogsMixin, WidgetsBindingObserver {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = getIt.get<AppRouter>();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        developer.log("app in resume");
        getIt.get<AuthenticationCubit>().checkAuthenAndUpdateGPS();
        break;
      case AppLifecycleState.inactive:
        developer.log("app in inactive");
        break;
      case AppLifecycleState.paused:
        getIt.get<AuthenticationCubit>().killTimer();
        developer.log("app in paused");
        break;
      case AppLifecycleState.detached:
        developer.log("app in detached");
        break;
      case AppLifecycleState.hidden:
        developer.log("app in hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return ScreenUtilInit(
      designSize: const Size(
        AppDimens.widthDefault,
        AppDimens.heightDefault,
      ),
      builder: (context, child) => GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt.get<LanguageBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<LoadingBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<SnackbarBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<DialogBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<AuthenticationCubit>(),
            ),
            BlocProvider(
              create: (_) => getIt.get<InternetCubit>(),
            ),
            BlocProvider(create: (_) => getIt.get<LocationCubit>())
          ],
          child: MaterialApp.router(
            title: AppConstant.appTitle,
            locale: localizationDelegate.currentLocale,
            routerConfig: _appRouter.config(),
            theme: appTheme(),
            builder: (context, widget) {
              return LoadingContainerWidget(
                child: _buildBlocListener(widget ?? const SizedBox(), context),
              );
            },
          ),
        ),
      ),
    );
  }

  MultiBlocListener _buildBlocListener(Widget widget, BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SnackbarBloc, SnackbarState>(
          listener: (context, state) {
            if (state is ShowSnackBarState) {
              TopSnackBar(
                title: translate(state.translationKey ?? ''),
                type: state.type ?? SnackBarType.success,
                key: state.key,
              ).showWithNavigator(
                  _appRouter.navigatorKey.currentState ?? NavigatorState(),
                  context);
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.unAuthenticated) {
              (_appRouter.navigatorKey.currentState?.context ??
                      NavigatorState().context)
                  .router
                  .replaceAll([const LoginPageRoute()]);
            } else if (state.status == AuthenticationStatus.authenticated) {
              (_appRouter.navigatorKey.currentState?.context ??
                      NavigatorState().context)
                  .router
                  .replaceAll([const DashBoardPageRoute()]);
            }
          },
        ),
        BlocListener<DialogBloc, DialogState>(
          listener: (context, state) {
            if (state is ShowAlertDialogState) {
              showAlertDialog(
                context: _appRouter.navigatorKey.currentState?.context ??
                    NavigatorState().context,
                type: DialogType.announce,
                title: state.title,
                mainMessage: state.mainMessage,
                message: state.message,
                buttonTitle: state.buttonTitle,
                textTransfer: state.textTransfer,
                settingAction: state.settingAction!(),
                acceptAction: state.acceptAction!(),
              );
            } else if (state is ShowOptionDialogState) {
              showAlertDialog(
                context: _appRouter.navigatorKey.currentState?.context ??
                    NavigatorState().context,
                type: DialogType.option,
                title: state.title,
                message: state.message,
                buttonTitle: state.buttonTitle,
                acceptAction: state.acceptAction!(),
                denyAction: state.denyAction!(),
              );
            }
          },
        ),
      ],
      child: widget,
    );
  }
}
