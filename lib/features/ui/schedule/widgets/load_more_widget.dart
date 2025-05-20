import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../common/themes/themes.dart';

class LoadMoreCircular extends StatelessWidget {
  const LoadMoreCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
            strokeWidth: 2,
          )).paddingAll(5),
    );
  }
}
