import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/themes/theme_color.dart';
import 'package:pipcar/common/themes/theme_text.dart';
import 'package:pipcar/core/presentation/bloc/snackbar_bloc/snackbar_bloc.dart';
import 'package:pipcar/core/presentation/routers/app_router.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/cubit/list_dispatch_cubit.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/list_dispatch_widget.dart';

class ListCarDispatchProvider extends StatelessWidget {
  final String driverId;

  const ListCarDispatchProvider({super.key, required this.driverId});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt.get<ListDispatchCubit>(),
    child: ListCarDispatchScreen(driverId: driverId));
  }
}
class ListCarDispatchScreen extends StatefulWidget {
  final String driverId;

  const ListCarDispatchScreen({super.key, required this.driverId});

  @override
  _ListCarDispacthScreen createState() => _ListCarDispacthScreen(driverId: driverId);
  
}

class _ListCarDispacthScreen extends State<ListCarDispatchScreen>{

  final String driverId;
  bool loaded = false;
  bool carsEmpty = false;
  int select = -1;
  bool selected = false;
  String? carSelectedId;

  _ListCarDispacthScreen({required this.driverId});

  @override
  void initState() {
    super.initState();
    context.read<ListDispatchCubit>().getListCar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Giao xe",
        titleStyle: ThemeText.appBar.copyWith(color: AppColor.primaryColor),
      ),
      body: BlocConsumer<ListDispatchCubit, ListDispatchState>(
        listener: (context, state) {
          if(state.status == ListDispatchStatus.canceled){
            context.read<ListDispatchCubit>().getListCar();
            getIt.get<SnackbarBloc>().showSnackbar(
              translationKey: "Huỷ giao xe thành công",
              type: SnackBarType.success
            );
          }
        },
        builder: (context, state) {
          if(state.status != ListDispatchStatus.loaded){
            selected = false;
            select = -1;
            carSelectedId = null;
            return const ShimmerLoading();
          }
          if(state.cars.isEmpty == true && !loaded) {
            context.read<ListDispatchCubit>().getListCar();
            loaded = true;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RefreshIndicator(
                onRefresh: () =>
                      context.read<ListDispatchCubit>().getListCar(),
                child: 
                state.cars.isEmpty 
                        ? Container(
                          alignment: Alignment.topCenter,
                          child: StyleLabel(
                            title: "Tài khoản hết xe.\n\nĐể đăng ký thêm xe kinh doanh, bạn\nvui lòng liên hệ với chăm sóc khách\nhàng của Pipcar.",
                            textAlign: TextAlign.center,
                            style: ThemeText.mediumTextTicket.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ).paddingTop(AppDimens.paddingVeryLarge)
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                top: AppDimens.paddingSmall),
                            itemCount: state.cars.length,
                            itemBuilder:(context, index) {
                              return 
                              GestureDetector(
                                child: 
                                CarItem(car: state.cars[index], select: select==index,onTap: () {
                                    setState(() => select = index); 
                                    selected = true;
                                    carSelectedId = state.cars[index].id;
                                  },
                                ),
                              );
                            },
                          ),
                ).expand(),
                state.cars.isEmpty ? const Spacer()
                  : GestureDetector(
                    child: TextButtonWidget(
                      onPressed: selected 
                      ? () {
                        context.read<ListDispatchCubit>().putDeliverCar(driverId, carSelectedId!);
                        context.router.pop();
                        context.router.pushNamed(Routes.dashBoard);
                        context.router.pushNamed(Routes.listDispatch);
                        }
                      : (){},
                      title: "Chọn xe",
                      titleColor: AppColor.white,
                      buttonColor: selected ? AppColor.primaryColor : AppColor.dividerColor,
                    ).paddingSymmetric(vertical: AppDimens.paddingVerticalApp),
                  )
            ],
          ).paddingSymmetric(horizontal: AppDimens.paddingHorizontalApp);
        },
      ),
    );
  }
}