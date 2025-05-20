import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/bloc/auth_bloc/auth_cubit.dart';
import 'package:pipcar/core/presentation/bloc/location_bloc/location_cubit.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/core/service/notification/notification_helper.dart';

import '../../../common/assets/assets.gen.dart';
import '../../../common/di/di.dart';
import '../../../common/themes/themes.dart';
import '../../../core/service/notification/fcm_service.dart';

@RoutePage()
class SplashPageProvider extends StatefulWidget {
  const SplashPageProvider({super.key});

  @override
  State<SplashPageProvider> createState() => _SplashPageProviderState();
}

class _SplashPageProviderState extends State<SplashPageProvider> {
  @override
  void initState() {
    super.initState();
    initServiceAndNavigate();
  }

  void initServiceAndNavigate() async {
    NotificationHelper.configFCM();
    await FirebaseMessagingService().initService();
    await LocationCubit.requestPermission();
    Future.delayed(const Duration(seconds: 1))
        .then((_) => getIt.get<AuthenticationCubit>().checkRefreshToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ImageAppWidget(
            path: Assets.images.background.keyName,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageAppWidget(
                  path: Assets.images.logoPipcarWhite.keyName,
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ).paddingBottom(AppDimens.paddingMedium),
                StyleLabel(
                        title: "Xe tìm chuyến",
                        style:
                            ThemeText.caption.copyWith(color: AppColor.white))
                    .paddingBottom(AppDimens.paddingSmall),
                StyleLabel(
                    title: "chuyến tìm xe",
                    style: ThemeText.caption.copyWith(color: AppColor.white)),
              ],
            ),
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state.status != AuthenticationStatus.serverError) {
                return const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: AppColor.white,
                    strokeWidth: 3,
                  ),
                );
              } else {
                return StyleLabel(
                  title: "Vui lòng kết nối internet để sử dụng ứng dụng",
                  style: ThemeText.caption.copyWith(
                    color: AppColor.white,
                  ),
                );
              }
            },
          ).paddingSymmetric(vertical: AppDimens.paddingLarge)
        ],
      ),
    );
  }
}
