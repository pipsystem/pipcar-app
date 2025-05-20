import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../common/themes/theme_color.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      //  color: AppColor.black.withOpacity(0.6),
      child: const Center(
        child: SpinKitThreeBounce(
          color: AppColor.white,
          size: 25,
        ),
      ),
    );
  }
}

class LoaderWidget2 extends StatelessWidget {
  const LoaderWidget2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      //  color: AppColor.black.withOpacity(0.6),
      child: const Center(
        child: SpinKitCircle(
          color: AppColor.primaryColor,
          size: 25,
        ),
      ),
    );
  }
}
