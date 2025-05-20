import 'package:either_dart/either.dart';

abstract class AgencyRepository {
  Future<Either<Exception, dynamic>> getAgencyInfor();

  Future<Either<Exception, dynamic>> getAgencyInforAnalyst(); //A2

  Future<Either<Exception, dynamic>> getAnalystExpense(); //A2

  Future<Either<Exception, dynamic>> getSalaryStatistic(
      Map<String, dynamic> param); //A4

  Future<Either<Exception, dynamic>> getDetailsDriverDispatch(
      String agencyId); //A4

  Future<Either<Exception, dynamic>> getDriverLocation(String driverId);

  Future<Either<Exception, dynamic>> getDetailsDriverA4(String driverId);

  Future<Either<Exception, dynamic>> blockAccount();

  Future<Either<Exception, dynamic>> getListAgencySearch(
      {required int carTypeId,
      required int districtId,
      required String provinceId,
      required String pickUpTime});

  Future<Either<Exception, dynamic>> getAgencySearchInfor(
      {required String agencyId, required String carId});

  Future<Either<Exception, dynamic>> getPhoneAgency(
      {required String agencyId, required String carId});

  Future<Either<Exception, dynamic>> getListDistrict(String provinceId);

  Future<Either<Exception, dynamic>> getListDistrictSearch(String provinceId, String name);

  Future<Either<Exception, dynamic>> getListProvince();

  Future<Either<Exception, dynamic>> getListProvinceSearch(String name);

  Future<void> updateGPS({required double lat, required double long});
}
