import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pipcar/common/utils/app_utils.dart';

class WillPopWidget extends StatefulWidget {
  final Widget child;
  const WillPopWidget({super.key, required this.child});

  @override
  State<WillPopWidget> createState() => _WillPopWidgetState();
}

class _WillPopWidgetState extends State<WillPopWidget> {
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: widget.child);
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      AppUtils.showToast(translate('tap_again_to_exit'));
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
}
