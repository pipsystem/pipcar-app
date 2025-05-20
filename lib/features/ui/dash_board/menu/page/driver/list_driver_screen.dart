import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/cubit/list_driver_cubit.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/delivery_car/delivery_car_screen.dart';

import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../components/card_view.dart';
import '../../../components/dialog_view.dart';
import 'list_driver_strings.dart';
import 'list_driver_widget.dart';

@RoutePage()
class ListDriverProvider extends StatelessWidget {
  const ListDriverProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ListDriverCubit>(),
      child: Builder(builder: (context) {
        return Scaffold(
            appBar: AppBarWidget(
              title: ListDriverStrings.listDriver,
              titleStyle:
                  ThemeText.appBar.copyWith(color: AppColor.primaryColor),
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => FormDriverWidget.showFormAdd(context),
            //   backgroundColor: AppColor.primaryColor,
            //   child: const Icon(
            //     Icons.add,
            //     color: AppColor.white,
            //   ),
            // ),
            body: BlocBuilder<ListDriverCubit, ListDriverState>(
              builder: (context, state) {
                if (state.status == ListDriverStatus.loading) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 6,
                      itemBuilder: (context, index) => SizedBox(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height / 9,
                            child: const ShimmerLoading()
                                .paddingBottom(AppDimens.paddingVerySmall),
                          ));
                } else if (state.status == ListDriverStatus.loaded) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<ListDriverCubit>().getListDriver(),
                    child: state.drivers.isEmpty
                        ? const Center(
                            child: StyleLabel(
                              title: "Không có dữ liệu",
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.drivers.length,
                            itemBuilder: (context, index) => SizedBox(
                                  // dismissThresholds: const {
                                  //   DismissDirection.endToStart: 0.3
                                  // },
                                  // background: Container(
                                  //   decoration: BoxDecoration(
                                  //       color: Colors.red,
                                  //       borderRadius: BorderRadius.circular(
                                  //           AppDimens.borderSmall)),
                                  //   child: const Center(
                                  //       child: Icon(Icons.delete,
                                  //           color: AppColor.white)),
                                  // ),
                                  // direction: DismissDirection.endToStart,
                                  // key: ValueKey<int>(index),
                                  // confirmDismiss:
                                  //     (DismissDirection direction) async {
                                  //   return await DialogConfirmDelete
                                  //       .showConfirmDelete(
                                  //           context,
                                  //           ListDriverStrings
                                  //               .cofirmDeleteDriver);
                                  // },
                                  // onDismissed: (DismissDirection direction) {
                                  //   context
                                  //       .read<ListDriverCubit>()
                                  //       .deleteDriver(
                                  //           state.drivers[index].driverId);
                                  // },
                                  child: state.drivers[index].carInfor != null
                                      ? DriverHasCarWidget(
                                          driver: state.drivers[index])
                                      : (state.agencyInfor!.agencyType == "A4" && state.drivers.length == 1) ? const Center(
                                              child: StyleLabel(
                                                title: "Chưa được giao xe",
                                              ),
                                            )
                                          : ButtonStyle2(
                                          prefixIcon: ImageAppWidget(
                                            height: AppDimens.buttonIconSize,
                                            path:
                                                Assets.images.icPerson.keyName,
                                            color: AppColor.primaryColor,
                                          ).paddingSymmetric(
                                              horizontal:
                                                  AppDimens.paddingVerySmall),
                                          title: state.drivers[index].name,
                                          subtitle: state.drivers[index].phone,
                                          hasAction: false,
                                          onPressed: () => {}
                                            // BlocProvider.value(
                                            //     value: context
                                            //         .read<ListDriverCubit>(),
                                            //     child: DeliveryCarScreen(
                                            //         driverId: state
                                            //             .drivers[index]
                                            //             .driverId),
                                            //   ).launch(context)
                                              )
                                )),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ).paddingSymmetric(
                vertical: AppDimens.paddingVerticalApp,
                horizontal: AppDimens.paddingHorizontalApp));
      }),
    );
  }
}
