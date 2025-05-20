import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../common/di/di.dart';
import '../../../core/presentation/bloc/location_bloc/location_cubit.dart';
import '../repository/agency_repository.dart';

@injectable
class AgencyUseCase {
  final AgencyRepository _repository;

  AgencyUseCase(this._repository);

  Future<Either<Exception, dynamic>> getAgencyInfor() async {
    final result = await _repository.getAgencyInfor();
    return result;
  }

  Future<Either<Exception, dynamic>> getAgencyInforAnalyst() async {
    final result = await _repository.getAgencyInforAnalyst();
    return result;
  }

  Future<Either<Exception, dynamic>> getSalaryStatistic(
      String supplierId) async {
    var params = {'supplier_id': supplierId};
    final result = await _repository.getSalaryStatistic(params);
    return result;
  }

  Future<Either<Exception, dynamic>> getAnalystExpense() async {
    final result = await _repository.getAnalystExpense();
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsDriverDispatch(
      String agencyId) async {
    final result = await _repository.getDetailsDriverDispatch(agencyId);
    return result;
  }

  Future<Either<Exception, dynamic>> getDriverLocation(String driverId) async {
    final result = await _repository.getDriverLocation(driverId);
    return result;
  }

  Future<Either<Exception, dynamic>> getDetailsDriverA4(String driverId) async {
    final result = await _repository.getDetailsDriverA4(driverId);
    return result;
  }

  Future<Either<Exception, dynamic>> blockAccount() async {
    final result = await _repository.blockAccount();
    return result;
  }

  Future<Either<Exception, dynamic>> getListAgencySearch(
      {required int carTypeId,
      required int districtId,
      required String provinceId,
      required String pickUpTime}) async {
    final result = await _repository.getListAgencySearch(
      carTypeId: carTypeId,
      districtId: districtId,
      provinceId: provinceId,
      pickUpTime: pickUpTime,
    );
    return result;
  }

  Future<Either<Exception, dynamic>> getAgencySearchInfor(
      {required String agencyId, required String carId}) async {
    final result =
        await _repository.getAgencySearchInfor(agencyId: agencyId, carId: carId);
    return result;
  }

  Future<Either<Exception, dynamic>> getPhoneAgency(
      {required String agencyId, required String carId}) async {
    final result =
        await _repository.getPhoneAgency(agencyId: agencyId, carId: carId);
    return result;
  }

  Future<Either<Exception, dynamic>> getListDistrict(String provinceId) async {
    final result = await _repository.getListDistrict(provinceId);
    return result;
  }

  Future<Either<Exception, dynamic>> getListDistrictSearch(String provinceId, String name) async {
    final result = await _repository.getListDistrictSearch(provinceId, name);
    return result;
  }

  Future<Either<Exception, dynamic>> getListProvince() async {
    final result = await _repository.getListProvince();
    return result;
  }

  Future<Either<Exception, dynamic>> getListProvinceSearch(String name) async {
    final result = await _repository.getListProvinceSearch(name);
    return result;
  }

  Future<void> updateGPS() async {
    // await LocationCubit().checkPermissionAndOpenSettings();
    final currentLocation = await getIt.get<LocationCubit>().getPosition();
    if (currentLocation.lat != null && currentLocation.long != null) {
      await _repository.updateGPS(
          lat: currentLocation.lat!, long: currentLocation.long!);
    }
  }
}
