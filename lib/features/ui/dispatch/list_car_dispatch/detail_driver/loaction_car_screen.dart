import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/themes/theme_color.dart';
import 'package:pipcar/common/utils/app_utils.dart';
import 'package:pipcar/core/presentation/widgets/appbar_widget/appbar_widget.dart';
import 'package:pipcar/core/presentation/widgets/button_widget/text_button_widget.dart';
import 'package:pipcar/core/presentation/widgets/item_car_infor.dart';
import 'package:pipcar/core/presentation/widgets/item_marker.dart';
import 'package:pipcar/core/presentation/widgets/loading_widget/loader_widget.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/domain/enterties/driver_info_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_location_entity.dart';

class LocationCarScreen extends StatefulWidget {
  final DriverInfoEntity driver;
  final DriverLocationEntity location;
  final String driverId;

  const LocationCarScreen({super.key, required this.location, required this.driverId, required this.driver});

  @override
  State<LocationCarScreen> createState() => _LocationCarState();
}

class _LocationCarState extends State<LocationCarScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  late CameraPosition _kZoomPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // Marker? marker;
  bool isLoading = true;
  // late Map<String, dynamic> data;
  late List<Map<String, dynamic>> data;
  final List<DriverLocationEntity> locations = [];
  // final ScrollController _scrollController = ScrollController();

  @override
  void dispose() async {
    mapController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    _getMapController();
    locations.add(widget.location);
    // data = {
    //   'key': GlobalKey(),
    //   'id': const MarkerId("1"),
    //   'position': LatLng(widget.location.lat.toDouble(), widget.location.long.toDouble()),
    //   'number': 1
    // };
    data = locations
        .map((e) => {
              'key': GlobalKey(),
              'id': MarkerId(e.distance.toInt().toString()),
              'position': LatLng(e.lat.toDouble(), e.long.toDouble()),
              'number': 1
            })
        .toList();
    _kZoomPosition = CameraPosition(
      target: LatLng(widget.location.lat.toDouble(), widget.location.long.toDouble()),
      zoom: 16,
    );
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 500)).then((_) {
              _setUpMarker();
              // _scrollController.animateToPosition(
                  // (1.sw * 0.9 + 5.w) * 0);
            }));
    initializeDateFormatting();
    super.initState();
  }

  void _getMapController() async {
    mapController = await _controller.future;
  }

  // void _setUpMarker() async {
  //   marker = await _generateMarkerFromWidget(data);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  void _setUpMarker() async {
    await Future.wait(data.map((e) async {
      Marker marker = await _generateMarkerFromWidget(e);
      markers[marker.markerId] = marker;
    }));

    setState(() {
      isLoading = false;
    });
  }

  // Future<Marker> _generateMarkerFromWidget(Map<String, dynamic> data) async {
  //   RenderRepaintBoundary boundary =
  //       data['key'].currentContext?.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage(pixelRatio: 4);
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   return Marker(
  //       markerId: data['id'],
  //       position: data['position'],
  //       icon: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()));
  // }

  Future<Marker> _generateMarkerFromWidget(Map<String, dynamic> data) async {
    RenderRepaintBoundary boundary =
        data['key'].currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 4);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return Marker(
        markerId: data['id'],
        position: data['position'],
        icon: BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List()));
  }

  // void _adjustCameraZoomToFitMarker(Marker marker) async {
  //   double minLat = double.infinity;
  //   double maxLat = -double.infinity;
  //   double minLng = double.infinity;
  //   double maxLng = -double.infinity;
  //   LatLng position = marker.position;
  //   if (position.latitude < minLat) minLat = position.latitude;
  //   if (position.latitude > maxLat) maxLat = position.latitude;
  //   if (position.longitude < minLng) minLng = position.longitude;
  //   if (position.longitude > maxLng) maxLng = position.longitude;
  //   LatLngBounds bounds = LatLngBounds(
  //     southwest: LatLng(minLat, minLng),
  //     northeast: LatLng(maxLat, maxLng),
  //   );

  //   CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
  //   (await _controller.future).animateCamera(cameraUpdate);
  // }

  void _adjustCameraZoomToFitMarkers(Set<Marker> markers) async {
    if (markers.isEmpty) return;

    LatLngBounds bounds = AppUtils.getLatLngBounds(markers);

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    (await _controller.future).animateCamera(cameraUpdate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(color: Colors.transparent, iconBackBlack: true,),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
        Stack(
        children: [
          isLoading
              ? Center(
                  child: Stack(
                    children: [
                      // Transform.translate(
                      //   offset: Offset(-1.sw * 2, -1.sh * 2),
                      //   child: RepaintBoundary(
                      //     key: data['key'],
                      //     child: const CustomMarker(name: '1'),
                      //   ),
                      // ),
                      ListView(
                        children: [
                          for (var e in data)
                            Transform.translate(
                              offset: Offset(-1.sw * 2, -1.sh * 2),
                              child: RepaintBoundary(
                                key: e['key'],
                                child: CustomMarker(name: '${e['number']}'),
                              ),
                            )
                        ],
                      ),
                      const LoaderWidget2(),
                    ],
                  ),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kZoomPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(markers.values),
                ),
          SizedBox(
            height: 240.h,
            child: Stack(
              children: [
                GestureDetector(
                  onDoubleTap: () => _adjustCameraZoomToFitMarkers(Set<Marker>.of(markers.values)),
                  onTap: () async {
                    log(widget.location.distance.toStringAsFixed(1));
                    (await _controller.future).animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                      target: LatLng(widget.location.lat.toDouble(), widget.location.long.toDouble()),
                      zoom: 16,
                    )));
                  },
                  child: ItemInforCarBase2(
                    driver: widget.location,
                    plate: widget.driver.carPlate,
                    phone: widget.driver.phone,
                    carTypeName: widget.driver.carTypeName,
                    carName: widget.driver.carName,
                    avatar: widget.driver.avatar,
                    distance: widget.location.distance < 1.0 ? "${(widget.location.distance*1000).toInt().toString()} m" : "${widget.location.distance.toStringAsFixed(2)} km",
                  ),
                ),
              ],
            ),
          ).paddingTop(AppDimens.paddingMedium),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: TextButtonWidget(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber(widget.driver.phone);
                    },
                    title: "Gọi lái xe",
                    titleColor: AppColor.white,
                    image: ImageAppWidget(
                      path: Assets.images.icLocalPhoneOutlined.keyName,
                      height: AppDimens.iconMediumSize,
                    ),
                    buttonColor: AppColor.primaryColor,
                    height: AppDimens.buttonSize,
                    width: MediaQuery.of(context).size.width,
                  ).paddingOnly(bottom: AppDimens.paddingLarge, left: AppDimens.paddingMedium, right: AppDimens.paddingMedium),
            ))
        ],
      ).expand(),
      ],)
      
    );
  }
}