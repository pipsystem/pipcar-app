import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_details/cubit/transaction_detail_cubit.dart';

import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_details/transaction_details_screen.dart';

import '../../../../../../../common/di/di.dart';

@RoutePage()
class TransactionDetailProvider extends StatelessWidget {
  final String transactionId;
  const TransactionDetailProvider({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<TransactionDetailCubit>(),
      child: TransactionDetailScreen(transactionId: transactionId),
    );
  }
}
