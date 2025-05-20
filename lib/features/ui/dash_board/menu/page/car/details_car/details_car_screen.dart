import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../../core/presentation/widgets/item_marker.dart';
import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../../domain/enterties/car_entity.dart';

@RoutePage()
class DetailsCarPageProvider extends StatefulWidget {
  final CarEntity car;
  const DetailsCarPageProvider({super.key, required this.car});

  @override
  State<DetailsCarPageProvider> createState() => _DetailsCarPageProviderState();
}

class _DetailsCarPageProviderState extends State<DetailsCarPageProvider> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kZoomPosition = const CameraPosition(
    target: LatLng(21.0044304, 105.8465979),
    zoom: 14.4746,
  );

  List<Map<String, dynamic>> data = [];

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  bool isLoading = true;

  @override
  void initState() {
    data.add({
      'key': GlobalKey(),
      'id': MarkerId(widget.car.id),
      'position':
          LatLng(widget.car.carLat.toDouble(), widget.car.carLong.toDouble()),
      'number': 1
    });
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Future.delayed(Duration(milliseconds: 500))
            .then((value) => _setUpMarker()));
    initializeDateFormatting();
    super.initState();
  }

  void _setUpMarker() async {
    _kZoomPosition = CameraPosition(
      target:
          LatLng(widget.car.carLat.toDouble(), widget.car.carLong.toDouble()),
      zoom: 14.4746,
    );
    await Future.wait(data.map((e) async {
      Marker marker = await _generateMarkerFromWidget(e);
      markers[marker.markerId] = marker;
    }));

    setState(() {
      isLoading = false;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(color: Colors.transparent, iconBackBlack: true),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: Stack(
                    children: [
                      const LoaderWidget2(),
                      ListView(
                        children: [
                          Transform.translate(
                            offset: Offset(-1.sw * 2, -1.sh * 2),
                            child: RepaintBoundary(
                              key: data.first['key'],
                              child: const CustomMarker(name: '1'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kZoomPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(markers.values),
                ),
          ItemInforCarBase(car: widget.car).onTap(() async {
            (await _controller.future)
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(
                  widget.car.carLat.toDouble(), widget.car.carLong.toDouble()),
              zoom: 14.5,
            )));
          }),
        ],
      ),
    );
  }
}
