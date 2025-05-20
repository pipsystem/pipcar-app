// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

import 'package:pipcar/core/presentation/bloc/base_bloc/base_bloc.dart';
import 'package:pipcar/core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

import '../../../../common/di/di.dart';

part 'location_state.dart';

@injectable
class LocationCubit extends BaseBloc<LocationState> {
  LocationCubit() : super(LocationState.init());

  static Location get _location => Location();

  @override
  void onInit() {}

  Future<LocationModel> getPosition() async {
    bool serviceEnabled;
    PermissionStatus permission;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      bool enabled = await _location.requestService();
      if (!enabled) {
        LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi bị deny
        return Future.error("Location service is disabled!");
      } else {
        bool serviceEnableCheckAgain = await _location.serviceEnabled();
        if (!serviceEnableCheckAgain) {
          LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi bị deny
          return Future.error("User is disabled service!");
        }
      }
    }

    permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission == PermissionStatus.denied) {
        LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi bị deny
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == PermissionStatus.deniedForever) {
      LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi bị deny
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LocationData position = await _location.getLocation();
    return LocationModel(lat: position.latitude, long: position.longitude);
  }

  void showPolicyDialog() async {
    PermissionStatus permission;
    bool serviceEnabled;
    serviceEnabled = await _location.serviceEnabled();
    permission = await _location.hasPermission();
    if (!serviceEnabled || permission == PermissionStatus.denied) {
      getIt.get<DialogBloc>().showAlertDialog(
          message: translate("alert_policy"),
          buttonTitle: "Tiếp tục",
          acceptAction: () async {
            getPosition();
          });
    }
  }

  //Permission
  static Future<void> requestPermission() async {
    PermissionStatus permission;

    permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      getIt.get<DialogBloc>().showAlertDialog(
          message: translate("alert_policy"),
          buttonTitle: "Tiếp tục",
          acceptAction: () async {
            permission = await _location.requestPermission();
            if (permission == PermissionStatus.denied) {
              LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi bị deny
              return Future.error('Location permissions are denied');
            }
          });
    }
    if (permission == PermissionStatus.deniedForever) {
      LocationCubit.checkPermissionAndOpenSettingsRequire(); //Bật hướng dẫn cài đặt GPS khi deny forever
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  static Future<void> checkPermissionAndOpenSettingsRequire() async {
    bool isAlertDialogShown = false;
    while (true) {
      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.granted) {
        break; // Break the loop if the permission is granted
      } else {
        if(!isAlertDialogShown) {
          isAlertDialogShown = true;
        getIt.get<DialogBloc>().showAlertDialog(
            message: "Quý khách hãy cấp quyền truy\ncập GPS để tiếp tục sử dụng\ndịch vụ.",
            textTransfer: "Đi tới cài đặt vị trí >",
            settingAction: () {
              perm.openAppSettings();
              isAlertDialogShown = false;
            }
          );

        }
      }
      // Add a delay before checking again to avoid continuous checking
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<PermissionStatus> checkPermissionAndOpenSettings() {
    return _location.hasPermission();
  }

  // Future<Either<Exception, dynamic>> putLocation(LocationModel location) async {
  //   Map<String, dynamic> body = {
  //     "lat": location.lat,
  //     "long": location.long,
  //   };
  // }

  @override
  Future<void> close() {
    return super.close();
  }
}

class LocationModel {
  double? lat;
  double? long;
  LocationModel({
    this.lat,
    this.long,
  });
}
