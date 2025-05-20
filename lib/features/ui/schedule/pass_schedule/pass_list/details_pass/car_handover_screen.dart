// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/themes/themes.dart';
import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/item_marker.dart';
import 'package:pipcar/features/domain/enterties/ticket/details_ticket.dart';
import 'package:pipcar/features/ui/schedule/pass_schedule/pass_list/details_pass/cubit/details_pass_cubit.dart';

import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';

class CarHandover extends StatefulWidget {
  final List<SupplierEntity> cars;
  final SupplierEntity selectCar;
  final String ticketId;
  const CarHandover(
      {super.key,
      required this.cars,
      required this.selectCar,
      required this.ticketId});

  @override
  State<CarHandover> createState() => _CarHandoverState();
}

class _CarHandoverState extends State<CarHandover> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late GoogleMapController mapController;
  late CameraPosition _kZoomPosition;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool isLoading = true;
  late List<Map<String, dynamic>> data;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() async {
    mapController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getMapController();
    data = widget.cars
        .map((e) => {
              'key': GlobalKey(),
              'id': MarkerId(e.id),
              'position': LatLng(e.carLat.toDouble(), e.carLong.toDouble()),
              'number': widget.cars.indexOf(e) + 1
            })
        .toList();
    _kZoomPosition = CameraPosition(
      target: LatLng(widget.selectCar.carLat.toDouble(),
          widget.selectCar.carLong.toDouble()),
      zoom: 16,
    );
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(const Duration(milliseconds: 500)).then((_) {
              _setUpMarker();
              _scrollController.animateToPosition(
                  (1.sw * 0.9 + 5.w) * widget.cars.indexOf(widget.selectCar));
            }));
    initializeDateFormatting();
    super.initState();
  }

  void _getMapController() async {
    mapController = await _controller.future;
  }

  void _setUpMarker() async {
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
      body: Stack(
        children: [
          isLoading
              ? Center(
                  child: Stack(
                    children: [
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
                      const LoaderWidget2()
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
          SizedBox(
            height: 240.h,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.cars.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Stack(
                children: [
                  GestureDetector(
                    onDoubleTap: () => _adjustCameraZoomToFitMarkers(
                        Set<Marker>.of(markers.values)),
                    onTap: () async {
                      (await _controller.future).animateCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(widget.cars[index].carLat.toDouble(),
                            widget.cars[index].carLong.toDouble()),
                        zoom: 16,
                      )));
                    },
                    child: ItemInforCarBase(
                      car: widget.cars[index],
                      supplier: widget.cars[index],
                      phone: widget.cars[index].supplierPhone,
                      carTypeName: widget.cars[index].supplierName + ' (${index + 1})',
                      distance: widget.cars[index].distance,
                    ),
                  ),
                  // TagForCar(name: '${index + 1}'),
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColor.primaryColor, width: 0.5),
                          borderRadius: BorderRadius.circular(17)),
                      child: StyleLabel(
                        title: "Giao",
                        style: ThemeText.body2
                            .copyWith(fontWeight: FontType.medium),
                      ).paddingAll(AppDimens.paddingVerySmall).paddingOnly(left: AppDimens.paddingMedium, right: AppDimens.paddingMedium),
                    ).onTap(() {
                      context.read<DialogBloc>().showOptionDialog(
                          message:
                              "Chủ lịch chú ý xem vị trí và trao đổi với lái xe trước khi giao dịch. \nLái xe: ${widget.cars[index].supplierName} \nSố điện thoại: ${widget.cars[index].supplierPhone}",
                          acceptAction: () async {
                            await context.read<DetailsPassCubit>().acceptTicket(
                                ticketId: widget.ticketId,
                                supplierId: widget.cars[index].id);
                            context.router.pop();
                            context.pushRoute(DashBoardPageRoute());
                            context.pushRoute(PassSchedulePageRoute(initialPage: 1));
                            context.pushRoute(DetailsAcceptedPageRoute(ticketId: widget.ticketId));
                          });
                    }),
                  ).paddingBottom(12).paddingRight(12))
                ],
              ),
            ),
          ).paddingTop(AppDimens.paddingMedium),
        ],
      ),
    );
  }
}

class TagForCar extends StatelessWidget {
  final String name;
  const TagForCar({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 20,
      child: Container(
        width: 30,
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.primaryColor, width: 2),
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            name,
            style: ThemeText.note.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
