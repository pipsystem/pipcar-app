// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_list/cubit/transaction_list_cubit.dart';
import 'package:pipcar/features/ui/dash_board/menu/page/transation/transaction_list/transaction_list_screen.dart';

@RoutePage()
class TransactionListProvider extends StatelessWidget {
  final int currentCoin;
  const TransactionListProvider({
    Key? key,
    required this.currentCoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<TransactionListCubit>(),
      child: TransactionListScreen(
        currentCoin: currentCoin,
      ),
    );
  }
}
