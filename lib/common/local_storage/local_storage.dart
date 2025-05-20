import 'package:get_storage/get_storage.dart';

class StorageKey {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String deviceId = 'device_id';
  static const String payloadNotify = 'payload_noti';
  static const String agencyId = 'agency_id';
  static const String carTypeId = 'car_type_id';
}

// Pub: https://pub.dev/packages/get_storage

class LocalStorage {
  // Explain: Khi khai bao nhu phia duoi thi no se tu sinh ra : GetStorage de luu tru du lieu
  // mockup
  static final LocalStorage _localStorage = LocalStorage._internal();

  factory LocalStorage() {
    return _localStorage;
  }

  LocalStorage._internal();

  static final accessToken = ''.val(StorageKey.accessToken);
  static final refreshToken = ''.val(StorageKey.refreshToken);
  static final deviceId = ''.val(StorageKey.deviceId);
  static final payloadNotify = ''.val(StorageKey.payloadNotify);
  static final agencyId = ''.val(StorageKey.agencyId);
  static final carTypeId = 0.val(StorageKey.carTypeId);

  static void saveToken({required String aT, required String rT}) {
    accessToken.val = aT;
    refreshToken.val = rT;
  }

  static void clearToken() {
    accessToken.val = "";
    refreshToken.val = "";
    payloadNotify.val = "";
    agencyId.val = "";
    carTypeId.val = 0;
  }
}
