import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pipcar/common/di/di.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/cubit/details_driver_cubit.dart';
import 'package:pipcar/features/ui/dispatch/list_car_dispatch/detail_driver/details_driver_screen.dart';

class DetailsDriverProvider extends StatelessWidget {
  final String agencyId;
  final String carId;
  final String driverId;

  const DetailsDriverProvider({super.key, required this.agencyId, required this.carId, required this.driverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<DetailsDriverCubit>(),
      child: DetailsDriverScreen(agencyId: agencyId, carId: carId, driverId: driverId)
    );
  }
}