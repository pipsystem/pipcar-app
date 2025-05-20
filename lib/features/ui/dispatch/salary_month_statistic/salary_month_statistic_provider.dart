// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/themes/themes.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:pipcar/features/ui/dispatch/salary_month_statistic/cubit/salary_month_statistic_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../common/assets/assets.gen.dart';
import '../widget/item_coin_widget.dart';

part 'salary_month_statistic_screen.dart';

@RoutePage()
class SalaryMonthStatisticProvider extends StatelessWidget {
  final String supplierId;
  const SalaryMonthStatisticProvider({
    Key? key,
    required this.supplierId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SalaryMonthStatisticCubit>(),
      child: SalaryStatisticScreen(
        supplierId: supplierId,
      ),
    );
  }
}
