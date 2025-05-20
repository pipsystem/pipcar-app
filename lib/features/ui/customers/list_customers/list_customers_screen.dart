import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/assets/assets.gen.dart';
import 'package:pipcar/features/ui/customers/list_customers/cubit/list_customers_cubit.dart';

import '../../../../common/configs/constants/app_dimens.dart';
import '../../../../common/di/di.dart';
import '../../../../common/themes/theme_color.dart';
import '../../../../common/themes/theme_text.dart';
import '../../../../core/presentation/widgets/appbar_widget/appbar_widget.dart';
import '../../../../core/presentation/widgets/image_app_widget/image_app.dart';
import '../../../../core/presentation/widgets/loading_widget/shimmer_loading.dart';
import '../../../../core/presentation/widgets/scaffold_widget/scaffold_widget.dart';
import '../../../../core/presentation/widgets/text_widget/style_lable.dart';
import '../../dash_board/components/card_view.dart';

@RoutePage()
class ListCustomersProvider extends StatelessWidget {
  const ListCustomersProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ListCustomersCubit>(),
      child: Builder(builder: (context) {
        return ScaffoldWidget(
            appbar: AppBarWidget(
              title: "Danh sách khách hàng",
              titleStyle:
                  ThemeText.appBar.copyWith(color: AppColor.primaryColor),
            ),
            body: BlocBuilder<ListCustomersCubit, ListCustomersState>(
              builder: (context, state) {
                if (state.status == ListCustomersStatus.loading) {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 6,
                      itemBuilder: (context, index) => SizedBox(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height / 9,
                            child: const ShimmerLoading()
                                .paddingBottom(AppDimens.paddingVerySmall),
                          ));
                } else if (state.status == ListCustomersStatus.loaded) {
                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<ListCustomersCubit>().getListCustomers(),
                    child: state.customers.isEmpty
                        ? const Center(
                            child: StyleLabel(
                              title: "Không có dữ liệu",
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                top: AppDimens.paddingSmall),
                            itemCount: state.customers.length,
                            itemBuilder: (context, index) => ButtonStyle2(
                                  prefixIcon: ImageAppWidget(
                                    height: AppDimens.buttonIconSize,
                                    path: Assets.images.icPerson.keyName,
                                    color: AppColor.primaryColor,
                                  ).paddingSymmetric(
                                      horizontal: AppDimens.paddingVerySmall),
                                  sufixIcon: Visibility(
                                    visible:
                                        state.customers[index].customer_phone !=
                                            '',
                                    child: InkWell(
                                      onTap: () =>
                                          FlutterPhoneDirectCaller.callNumber(
                                              state.customers[index]
                                                  .customer_phone),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.borderCard),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.call,
                                              color: AppColor.green,
                                              size: AppDimens.iconMediumSize,
                                            ),
                                            StyleLabel(
                                              title: " Gọi",
                                              style: ThemeText.body2
                                                  .copyWith(height: 1.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: state.customers[index].customer_name,
                                  subtitle:
                                      state.customers[index].customer_phone,
                                  hasAction: false,
                                  onPressed: () {},
                                )),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ));
      }),
    );
  }
}
