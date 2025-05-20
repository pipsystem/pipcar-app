// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/features/ui/dispatch/dispatch/cubit/dispatch_cubit.dart';
import 'package:pipcar/features/ui/dispatch/dispatch/dispatch_screen.dart';

import '../../../domain/enterties/dispatch/driver_delivering_entity.dart';

@RoutePage()
class DispatchPageProvider extends StatelessWidget {
  final DriverDeleveringEntity driver;

  const DispatchPageProvider({
    Key? key,
    required this.driver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DispatchCubit>(),
      child: DispatchScreen(driver: driver),
    );
  }
}
