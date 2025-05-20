import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../themes/themes.dart';

bool isNullEmpty(Object? o) => o == null || "" == o || o == "null";

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) =>
    o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNullEmptyList<T>(List<T>? t) => t == null || [] == t || t.isEmpty;

bool isNullEmptyMap<T>(Map<T, T>? t) => t == null || {} == t || t.isEmpty;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  if (isNullEmpty(sConvert)) {
    return false;
  }
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}

class AppUtils {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColor.lightGrey.withOpacity(0.8),
      textColor: AppColor.black,
    );
  }

  static LatLngBounds getLatLngBounds(Set<Marker> markers) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;

    for (Marker marker in markers) {
      LatLng position = marker.position;

      if (position.latitude < minLat) minLat = position.latitude;
      if (position.latitude > maxLat) maxLat = position.latitude;
      if (position.longitude < minLng) minLng = position.longitude;
      if (position.longitude > maxLng) maxLng = position.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    return bounds;
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
