import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/features/domain/repository/agency_repository.dart';

import '../source/agency_remote_data_source.dart';

@Injectable(as: AgencyRepository)
class AgencyRepositoryImpl extends AgencyRepository {
  final AgencyRemoteDataSource remoteDataSource;

  AgencyRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, dynamic>> getAgencyInfor() async {
    final result = await remoteDataSource.getAgencyInfor();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getAgencyInforAnalyst() async {
    final result = await remoteDataSource.getAgencyInforAnalyst();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getSalaryStatistic(
      Map<String, dynamic> param) async {
    final result = await remoteDataSource.getSalaryStatistic(param);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getAnalystExpense() async {
    final result = await remoteDataSource.getAnalystExpense();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDriverDispatch(
      String agencyId) async {
    final result = await remoteDataSource.getDetailsDriverDispatch(agencyId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDriverLocation(
      String driverId) async {
    final result = await remoteDataSource.getDriverLocation(driverId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDriverA4(
      String driverId) async {
    final result = await remoteDataSource.getDetailsDriverA4(driverId);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> blockAccount() async {
    final result = await remoteDataSource.blockAccount();
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListAgencySearch(
      {required int carTypeId,
      required int districtId,
      required String provinceId,
      required String pickUpTime}) async {
    var params = {
      'car_type_id': carTypeId,
      'province_id': provinceId,
      'district_id': districtId,
      'pickup_time': pickUpTime,
    };
    final result = await remoteDataSource.getListAgencySearch(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getAgencySearchInfor(
      {required String agencyId, required String carId}) async {
    var params = {
      'agency_id': agencyId,
      'car_id': carId,
    };
    final result = await remoteDataSource.getAgencySearchInfor(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getPhoneAgency(
      {required String agencyId, required String carId}) async {
    var params = {
      'agency_id': agencyId,
      'car_id': carId,
    };
    final result = await remoteDataSource.getPhoneAgency(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListDistrict(String provinceId) async {
    var params = {'p': provinceId};
    final result = await remoteDataSource.getAddress(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListDistrictSearch(String provinceId, String name) async {
    var params = {'p': provinceId, 'name': name};
    final result = await remoteDataSource.getAddressSearch(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListProvince() async {
    Map<String, dynamic> params = {};
    final result = await remoteDataSource.getAddress(params);
    return result;
  }

  @override
  Future<Either<Exception, dynamic>> getListProvinceSearch(String name) async {
    Map<String, dynamic> params = {'name': name};
    final result = await remoteDataSource.getAddressSearch(params);
    return result;
  }

  @override
  Future<void> updateGPS({required double lat, required double long}) async {
    var body = {'lat': lat.toString(), 'long': long.toString()};
    remoteDataSource.updateGPS(body);
  }
}
