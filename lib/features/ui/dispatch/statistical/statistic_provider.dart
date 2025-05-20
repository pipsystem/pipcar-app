import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/configs/constants/app_dimens.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/common/utils/extension_utils.dart';
import 'package:pipcar/core/presentation/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../common/assets/assets.gen.dart';
import '../../../../common/themes/themes.dart';
import '../widget/item_coin_widget.dart';
import 'cubit/statistic_expense_cubit.dart';

part 'statistic_screen.dart';

@RoutePage()
class StatiticExpenseProvider extends StatelessWidget {
  const StatiticExpenseProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<StatisticExpenseCubit>(),
      child: const StatisticScreen(),
    );
  }
}
