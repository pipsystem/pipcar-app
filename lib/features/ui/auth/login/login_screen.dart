import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/core/presentation/bloc/location_bloc/location_cubit.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/auth/login/cubit/login_cubit.dart';
import 'package:pipcar/features/ui/auth/login/login_strings.dart';

import '../../../../common/di/di.dart';
import '../../../../common/themes/themes.dart';
import '../../../../common/utils/utils_src.dart';
import '../../../../core/presentation/bloc/internet_bloc/internet_cubit.dart';
import '../../../../core/presentation/widgets/internet_disconnect_widget.dart';

@RoutePage()
class LoginPageProvider extends StatelessWidget {
  const LoginPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LoginCubit>(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent));
      getIt.get<LocationCubit>().showPolicyDialog();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Stack(
        children: [
          ImageAppWidget(
            path: Assets.images.background.keyName,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          ScaffoldWidget(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<InternetCubit, InternetState>(
                      builder: (context, state) {
                        if (state.status == InternetStatus.disconnected) {
                          return const InternetDisconnect().paddingSymmetric(
                              vertical: AppDimens.paddingLarge);
                        } else {
                          return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.1);
                        }
                      },
                    ),
                    const LogoLoginWidget(),
                    const LoginFormWidget(),
                    AppDimens.sizedBoxHeight10,
                    const TermWidget(),
                  ],
                ).paddingSymmetric(
                  vertical: AppDimens.paddingVertical10,
                ),
              )),
        ],
      ),
    );
  }
}

class LogoLoginWidget extends StatelessWidget {
  const LogoLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ImageAppWidget(
          path: Assets.images.logoPipcarWhite.keyName,
          width: 40.w,
          fit: BoxFit.fitWidth,
        ).paddingRight(AppDimens.paddingMedium),
        StyleLabel(
          title: AppConstant.appTitle,
          style: ThemeText.body2.copyWith(color: AppColor.white),
        )
      ],
    ).paddingSymmetric(vertical: AppDimens.paddingVeryLarge);
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFieldWidget(
            controller: context.read<LoginCubit>().phoneController,
            hintText: LoginStrings.hintPhone,
            keyboardType: TextInputType.phone,
            autoFocus: true,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return LoginStrings.phoneEmpty;
              } else if (!AppUtils.validateMobile(value.trim())) {
                return LoginStrings.phoneFailedValidate;
              }
              return null;
            },
            textStyle: ThemeText.caption.copyWith(color: AppColor.white),
          ).paddingBottom(AppDimens.paddingMedium),
          TextFieldWidget(
            controller: context.read<LoginCubit>().otpController,
            hintText: LoginStrings.hintOtp,
            textStyle: ThemeText.caption.copyWith(color: AppColor.white),
            keyboardType: TextInputType.number,
            validate: (value) {
              if (value == null || value.isEmpty) {
                return LoginStrings.codeEmpty;
              } else if (value.length != 6) {
                return LoginStrings.codeFailedValidate;
              }
              return null;
            },
            isSecure: true,
          ).paddingBottom(AppDimens.paddingMedium),
          TextButtonWidget(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (formKey.currentState!.validate()) {
                context.read<LoginCubit>().login();
              }
            },
            title: LoginStrings.login,
          ),
        ],
      ),
    );
  }
}

class TermWidget extends StatelessWidget {
  const TermWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          StyleLabel(
            title: LoginStrings.continueAndAgree,
            style: ThemeText.style12Regular.copyWith(
              color: AppColor.white,
            ),
          ),
          StyleLabel(
            title: LoginStrings.term,
            style: ThemeText.style12Regular.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          )
        ],
      ),
    ).onTap(() => context.router.pushNamed(Routes.term));
  }
}
