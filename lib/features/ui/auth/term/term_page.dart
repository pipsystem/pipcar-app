import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/configs/constants/icon_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../core/presentation/widgets/appbar_widget/appbar_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../login/login_strings.dart';

@RoutePage()
class TermPageProvider extends StatefulWidget {
  const TermPageProvider({super.key});

  @override
  State<TermPageProvider> createState() => _TermPageProviderState();
}

class _TermPageProviderState extends State<TermPageProvider> {
  late WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String url = "https://api.pipcar.vn/s/term.html";
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        appbar: AppBarWidget(
          title: LoginStrings.term,
          leading: SizedBox(
            width: AppbarConstants.buttonSize,
            height: AppbarConstants.buttonSize,
            child: SvgPicture.asset(IconConstants.iconBack)
                .paddingAll(AppDimens.paddingSmall)
                .onTap(
                  () => context.router.pop(),
                ),
          ),
        ),
        backgroundImage: ImageAppWidget(
          path: Assets.images.background.keyName,
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.borderSmall),
            color: Colors.white,
          ),
          child: WebViewWidget(controller: _controller),
        ).paddingSymmetric(vertical: AppDimens.paddingVertical10));
  }
}
