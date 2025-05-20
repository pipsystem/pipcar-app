// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/themes/themes.dart';
import 'package:pipcar/common/utils/extension_utils.dart';
import 'package:pipcar/features/domain/enterties/entities.dart';
import 'package:pipcar/features/ui/dash_board/search/config/configs_screen.dart';
import 'package:pipcar/features/ui/dash_board/search/cubit/search_cubit.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../core/presentation/widgets/item_marker.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import 'config/type_car_screen.dart';

@RoutePage()
class SearchPageProvider extends StatefulWidget {
  const SearchPageProvider({super.key});

  @override
  State<SearchPageProvider> createState() => _SearchPageProviderState();
}

class _SearchPageProviderState extends State<SearchPageProvider> {
  List<Map<String, dynamic>> dataMarker = [];
  bool loadingMarker = true;

  Future<Map<MarkerId, Marker>> _markersAgency(
      List<AgencySearchEntity> agencies) async {
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    if (dataMarker.isNotEmpty) {
      await Future.wait(dataMarker.map((e) async {
        Marker marker = await _generateMarkerFromWidget(e);
        markers[marker.markerId] = marker;
      }));
    }
    return markers;
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
    return BlocProvider(
      create: (context) => getIt.get<SearchCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: const AppBarWidget(color: Colors.transparent, iconBackBlack: true),
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) async {
              if (state.statusMarker == LoadMarkerStatus.loading) {
                dataMarker = state.agencies
                    .map((e) => {
                          'key': GlobalKey(),
                          'id': MarkerId(e.id),
                          'position':
                              LatLng(e.carLat.toDouble(), e.carLong.toDouble()),
                          'number': state.agencies.indexOf(e) + 1
                        })
                    .toList();
                setState(() {
                  loadingMarker = false;
                });
                Future.delayed(const Duration(milliseconds: 500))
                    .then((value) async {
                  final markersNew = await _markersAgency(state.agencies);
                  context.read<SearchCubit>().updateMarker(markersNew);
                });
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  loadingMarker
                      ? SizedBox()
                      : ListView(
                          children: [
                            for (var e in dataMarker)
                              RepaintBoundary(
                                key: e['key'],
                                child: CustomMarker(
                                    name: '${dataMarker.indexOf(e) + 1}'),
                              )
                          ],
                        ),
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(21.007144, 105.8439976),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      context
                          .read<SearchCubit>()
                          .mapController
                          .complete(controller);
                    },
                    markers: Set<Marker>.of(state.markers.values),
                  ),
                  SizedBox(
                    height: 240.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: state.agencies.length,
                        itemBuilder: (context, index) => Stack(
                              children: [
                                ItemInforCarBase(
                                  agency: state.agencies[index],
                                  car: state.agencies[index],
                                  carTypeName: state.carTypeEntity.name + ' (${index + 1})',
                                  distance: state.agencies[index].distance1,
                                )
                                    .onTap(() => context
                                        .read<SearchCubit>()
                                        .zoomToAgencySpecific(
                                            state.agencies[index]))
                                    .paddingLeft(5.w),
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: _buildButtonCall(
                                      context, state.agencies[index]),
                                ))
                              ],
                            )),
                  ).paddingTop(AppDimens.paddingMedium),
                  const ConfigWidgets()
                ],
              );
            },
        ));
      }),
    );
  }

  Widget _buildButtonCall(BuildContext context, AgencySearchEntity agency) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderCard),
          borderRadius: BorderRadius.circular(17)),
      padding: const EdgeInsets.only(bottom: 3),
      margin: const EdgeInsets.all(AppDimens.paddingSmall),
      width: 80,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageAppWidget(
            path: Assets.images.icPhone.keyName,
            width: 16.w,
          ),
          StyleLabel(
            title: "Gọi",
            style: ThemeText.body1,
          ),
        ],
      ),
    )
    .onTap(() => context.read<SearchCubit>().getPhoneAgency(agency));
  }
}

class ConfigWidgets extends StatelessWidget {
  const ConfigWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColor.white,
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ItemConfig(
                    title: "Cấu hình tìm kiếm",
                    content: state.status == SearchStatus.loaded
                        ? "${state.selectedDistrict?.name}, ${context.read<SearchCubit>().pickUpTimeController.text.getDatePickUpTime()}"
                        : "Đang tải",
                    prefixIconPath: Assets.images.icConfig.keyName,
                  ).onTap(() => BlocProvider.value(
                        value: context.read<SearchCubit>(),
                        child: const ConfigSearchScreen(),
                      ).launch(context)),
                  Divider(color: AppColor.dividerColor, height: 0.h)
                      .paddingSymmetric(horizontal: 20.w),
                  ItemConfig(
                    title: "Loại xe",
                    content: state.carTypeEntity.name,
                    prefixIconPath: Assets.images.icCars.keyName,
                  ).paddingBottom(AppDimens.paddingVerySmall).onTap(() => BlocProvider.value(
                        value: context.read<SearchCubit>(),
                        child: const TypeCarPageProvider(),
                      ).launch(context))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemConfig extends StatelessWidget {
  final String title;
  final String content;
  final String prefixIconPath;
  const ItemConfig(
      {super.key,
      required this.title,
      required this.content,
      required this.prefixIconPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageAppWidget(path: prefixIconPath, height: 12.h),
        AppDimens.sizedBoxWidth10,
        StyleLabel(title: title, style: ThemeText.style12Regular),
        StyleLabel(
          title: content,
          style: ThemeText.style12Regular.copyWith(fontWeight: FontWeight.w300),
          textAlign: TextAlign.end,
        ).expand(),
        AppDimens.sizedBoxWidth10,
      ],
    ).paddingSymmetric(vertical: 16.h, horizontal: 10.w);
  }
}
