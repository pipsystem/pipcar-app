import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';

import '../../../../../../common/assets/assets.gen.dart';
import '../../../../../../common/configs/constants/app_constant.dart';
import '../../../../../../common/di/di.dart';
import '../../../../../../common/themes/themes.dart';
import '../../../../../../core/presentation/routers/app_router.dart';
import '../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../domain/enterties/car_type_entity.dart';
import '../../../components/card_view.dart';
import '../../../components/dialog_view.dart';
import 'cubit/car_list_cubit.dart';
import 'list_car_strings.dart';

part 'list_car_widgets.dart';

@RoutePage()
class ListCarProvider extends StatelessWidget {
  const ListCarProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt.get<CarListCubit>(),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBarWidget(
                title: ListCarStrings.listCar,
                titleStyle:
                    ThemeText.appBar.copyWith(color: AppColor.primaryColor),
              ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () => FormCarWidget.showFormAdd(context),
              //   backgroundColor: AppColor.primaryColor,
              //   child: const Icon(
              //     Icons.add,
              //     color: AppColor.white,
              //   ),
              // ),
              body: BlocBuilder<CarListCubit, CarListState>(
                builder: (context, state) {
                  if (state.status == CarListStatus.loading) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 6,
                        itemBuilder: (context, index) => SizedBox(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height / 9,
                              child: const ShimmerLoading()
                                  .paddingBottom(AppDimens.paddingVerySmall),
                            ));
                  } else if (state.status == CarListStatus.loaded) {
                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<CarListCubit>().getListCar(),
                      child: state.cars.isEmpty
                          ? const Center(
                              child: StyleLabel(
                                title: "Không có dữ liệu",
                              ),
                            )
                          : ListView.builder(
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
                                          .showConfirmDelete(context,
                                              ListCarStrings.confirmDeleteCar);
                                    },
                                    key: ValueKey<int>(index),
                                    onDismissed: (DismissDirection direction) {
                                      context
                                          .read<CarListCubit>()
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
                                        onPressed: () => context.router.push(
                                            DetailsCarPageRoute(
                                                car: state
                                                    .cars[index]))).paddingTop(
                                        AppDimens.paddingSmall),
                                  )),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ).paddingSymmetric(
                  vertical: AppDimens.paddingMedium,
                  horizontal: AppDimens.paddingHorizontalApp));
        }));
  }
}
