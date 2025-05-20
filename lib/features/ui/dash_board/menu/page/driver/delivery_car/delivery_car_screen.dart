import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/cubit/list_driver_cubit.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/driver/delivery_car/cubit/delivery_car_cubit.dart';

import '../../../../../../../common/assets/assets.gen.dart';
import '../../../../../../../common/configs/constants/app_dimens.dart';
import '../../../../../../../common/di/di.dart';
import '../../../../../../../common/themes/themes.dart';
import '../../../../../../../core/presentation/bloc/dialog_bloc/dialog_bloc.dart';
import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../components/card_view.dart';
import '../../../../components/dialog_view.dart';
import '../../car/cubit/car_list_cubit.dart';
import '../../car/list_car_screen.dart';
import '../../car/list_car_strings.dart';

class DeliveryCarScreen extends StatelessWidget {
  final String driverId;
  const DeliveryCarScreen({super.key, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<CarListCubit>()),
          BlocProvider(create: (context) => getIt.get<DeliveryCarCubit>()),
        ],
        child: Builder(builder: (context) {
          return ScaffoldWidget(
              appbar: AppBarWidget(
                title: "Giao xe",
                titleStyle:
                    ThemeText.appBar.copyWith(color: AppColor.primaryColor),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final result = await FormCarWidget.showFormAdd(context);
                  if (result == true) {
                    // ignore: use_build_context_synchronously
                    context.read<DeliveryCarCubit>().getListCarUndelivery();
                  }
                },
                backgroundColor: AppColor.primaryColor,
                child: const Icon(
                  Icons.add,
                  color: AppColor.white,
                ),
              ),
              body: BlocBuilder<DeliveryCarCubit, DeliveryCarState>(
                builder: (context, state) {
                  if (state.status == DeliveryCarStatus.loading) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 6,
                        itemBuilder: (context, index) => SizedBox(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height / 9,
                              child: const ShimmerLoading()
                                  .paddingBottom(AppDimens.paddingVerySmall),
                            ));
                  } else if (state.status == DeliveryCarStatus.loaded) {
                    return state.cars.isEmpty
                        ? const Center(
                            child: StyleLabel(
                              title: "Không còn xe nào đang trống",
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => context
                                .read<DeliveryCarCubit>()
                                .getListCarUndelivery(),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.cars.length,
                                itemBuilder: (context, index) => Dismissible(
                                      dismissThresholds: const {
                                        DismissDirection.endToStart: 0.3
                                      },
                                      background: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                                AppDimens.borderSmall)),
                                        child: const Center(
                                            child: Icon(Icons.delete,
                                                color: AppColor.white)),
                                      ),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss:
                                          (DismissDirection direction) async {
                                        return await DialogConfirmDelete
                                            .showConfirmDelete(
                                                context,
                                                ListCarStrings
                                                    .confirmDeleteCar);
                                      },
                                      key: ValueKey<int>(index),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        context
                                            .read<DeliveryCarCubit>()
                                            .deleteCar(state.cars[index].id);
                                      },
                                      child: ButtonStyle2(
                                          prefixIcon: ImageAppWidget(
                                            height: AppDimens.buttonIconSize,
                                            path: Assets.images.icCars.keyName,
                                            color: AppColor.primaryColor,
                                          ).paddingSymmetric(
                                              horizontal:
                                                  AppDimens.paddingVerySmall),
                                          title: state.cars[index].carName,
                                          subtitle: state.cars[index].carPlates,
                                          onPressed: () async {
                                            final result = await context
                                                .read<DeliveryCarCubit>()
                                                .deliverCar(driverId,
                                                    state.cars[index].id);
                                            result.fold(
                                                (left) => getIt
                                                    .get<DialogBloc>()
                                                    .showAlertDialog(
                                                        message:
                                                            left.toString()),
                                                (right) {
                                              context
                                                  .read<ListDriverCubit>()
                                                  .getListDriver();
                                              context.pop();
                                            });
                                          }),
                                    )).paddingTop(AppDimens.paddingSmall),
                          );
                  } else {
                    return const SizedBox();
                  }
                },
              ).paddingSymmetric(horizontal: AppDimens.paddingHorizontalApp));
        }));
  }
}
