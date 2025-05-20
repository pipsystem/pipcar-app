import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_constant.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';

import '../../../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../../common/themes/themes.dart';
import 'cubit/list_dispatch_cubit.dart';
import 'list_dispatch_widget.dart';

@RoutePage()
class ListDispatchProvider extends StatelessWidget {
  const ListDispatchProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ListDispatchCubit>(),
      child: Builder(builder: (context) {
        return ScaffoldWidget(
            appbar: AppBarWidget(
              title: "Chọn xe điều phối",
              titleStyle:
                  ThemeText.appBar.copyWith(color: AppColor.primaryColor),
            ),
            body: Column(
              children: [
                BlocBuilder<ListDispatchCubit, ListDispatchState>(
                  builder: (context, state) {
                    if (state.status == ListDispatchStatus.loading) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: 6,
                          itemBuilder: (context, index) => SizedBox(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height / 9,
                                child: const ShimmerLoading()
                                    .paddingBottom(AppDimens.paddingVerySmall),
                              ));
                    } else if (state.status == ListDispatchStatus.loaded) {
                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<ListDispatchCubit>().getListDriver(),
                        child: 
                          state.drivers.isEmpty
                            ? const Center(
                              child: StyleLabel(
                                title: "Không có dữ liệu",
                              ),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.only(
                                  top: AppDimens.paddingSmall),
                              itemCount: state.drivers.length,
                              itemBuilder:(context, index) {
                                return DispatchCarItem(driver: state.drivers[index]);
                              },
                            ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ).expand(),
              ],
            ).paddingTop(AppDimens.paddingVeryLarge));
      }),
    );
  }
}
