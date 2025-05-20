import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:pipcar/common/exception/api_error.dart';
import 'package:pipcar/common/local_storage/local_storage.dart';
import 'package:pipcar/features/data/models/agency/address_search_response.dart';
import 'package:pipcar/features/data/models/agency/phone_response.dart';
import 'package:pipcar/features/data/models/dispatch/analyst_expense_response.dart';
import 'package:pipcar/features/data/models/dispatch/analyst_response.dart';
import 'package:pipcar/features/data/models/dispatch/infor_driver_dispatch_response.dart';
import 'package:pipcar/features/data/models/dispatch/salary_statistic__response.dart';
import 'package:pipcar/features/data/models/driver/driver_info_response.dart';
import 'package:pipcar/features/data/models/driver/driver_location_response.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_search_infor_entity.dart';

import '../../../common/di/di.dart';
import '../../../common/mixins/remote_data_source.dart';
import '../../../core/service/api_service/api_service.dart';
import '../../domain/enterties/entities.dart';
import '../mapper/mapper.dart';
import '../models/models.dart';

abstract class AgencyRemoteDataSource {
  Future<Either<Exception, dynamic>> getAgencyInfor();

  Future<Either<Exception, dynamic>> blockAccount();

  Future<Either<Exception, dynamic>> getListAgencySearch(
      Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getAgencySearchInfor(
    Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getPhoneAgency(
      Map<String, dynamic> params);

  Future<void> updateGPS(Map<String, dynamic> body);

  Future<Either<Exception, dynamic>> getAddress(Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getAddressSearch(Map<String, dynamic> params);

  Future<Either<Exception, dynamic>> getAgencyInforAnalyst(); //A2

  Future<Either<Exception, dynamic>> getAnalystExpense(); //A2

  Future<Either<Exception, dynamic>> getSalaryStatistic(
      Map<String, dynamic> params); //A4

  Future<Either<Exception, dynamic>> getDetailsDriverDispatch(
      String agencyId); // A4
  Future<Either<Exception, dynamic>> getDriverLocation(String driverId);

  Future<Either<Exception, dynamic>> getDetailsDriverA4(String driverId);

}

@Injectable(as: AgencyRemoteDataSource)
class AgencyRemoteDataSourceImpl extends AgencyRemoteDataSource
    with RemoteDataSource {
  final ApiService apiService = getIt.get<ApiService>();

  @override
  Future<Either<Exception, dynamic>> getAgencyInfor() {
    return call(() async {
      final result = await apiService
          .getAngencyInfor("Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data["agency_info"];
        AgencyInforResponse agencyResponse = AgencyInforResponse.fromJson(data);
        AgencyInforEntity agency =
            AgencyMapper.fromAgencyInforResponse(agencyResponse);
        return agency;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> blockAccount() {
    return call(() async {
      final result = await apiService
          .blockAccount("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        return result.data;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getAgencySearchInfor(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getPhoneAgency(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        PhoneResponse response = PhoneResponse.fromJson(data);
        return AgencyMapper.fromGetPhoneRespone(response);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getPhoneAgency(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getPhoneAgency(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        var phone = PhoneResponse.fromJson(result.data).phone;
        return phone;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getListAgencySearch(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getListAgencySearch(
          params, "Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data["agency_search_list"];
        List<dynamic> agencyResponseList =
            data.map((e) => AgencySearchResponse.fromJson(e)).toList();
        List<AgencySearchEntity> agencySearchList = agencyResponseList
            .map((e) => AgencyMapper.fromAgencySearchResponse(e))
            .toList();
        return agencySearchList;
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getAddress(Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getAddress(
          params, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        if (params['p'] != null) {
          //district
          final data = result.data["address_list"];
          List<dynamic> listDistrict =
              data.map((e) => DistrictResponse.fromJson(e)).toList();
          List<DistrictEntity> districts = listDistrict
              .map((e) => AgencyMapper.fromDistrictResponse(e))
              .toList();
          return districts;
        } else {
          final data = result.data["address_list"];
          List<dynamic> listProvince =
              data.map((e) => ProvinceResponse.fromJson(e)).toList();
          List<ProvinceEntity> provinces = listProvince
              .map((e) => AgencyMapper.fromProvinceResponse(e))
              .toList();
          return provinces;
        }
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<Either<Exception, dynamic>> getAddressSearch(Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getAddressSearch(params);
      // print(result.toString());
      if (result.status == RemoteDataContants.successStatus) {
        if (params['p'] != null) {
          final data = result.data["address_list"];
          List<dynamic> listDistrict =
              data.map((e) => AddressSearchResponse.fromJson(e)).toList();
          List<DistrictEntity> districts = listDistrict
              .map((e) => AgencyMapper.fromDistrictSearchResponse(e))
              .toList();
          return districts;
        } else {
          final data = result.data["address_list"];
          List<dynamic> listProvince =
              data.map((e) => AddressSearchResponse.fromJson(e)).toList();
          List<ProvinceEntity> provinces = listProvince
              .map((e) => AgencyMapper.fromProvinceSearchResponse(e))
              .toList();
          return provinces;
        }
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    }, isShowLoading: true);
  }

  @override
  Future<void> updateGPS(Map<String, dynamic> body) {
    return call(() async {
      final result = await apiService.updateGPS(
          body, "Bearer ${LocalStorage.accessToken.val}");
      print(result.toString());
    });
  }

  @override
  Future<Either<Exception, dynamic>> getAgencyInforAnalyst() {
    return call(() async {
      final result = await apiService
          .getInforAnalyst("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data["analyst"];
        AnalystResponse response = AnalystResponse.fromJson(data);
        return AgencyMapper.converAnalyst(response);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getAnalystExpense() {
    return call(() async {
      final result = await apiService
          .getInforAnalystExpense("Bearer ${LocalStorage.accessToken.val}");
      if (result.status == RemoteDataContants.successStatus) {
        final data = result.data;
        AnalystExpenseResponse response = AnalystExpenseResponse.fromJson(data);
        return AgencyMapper.convertExpenseAnalyst(response);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDriverDispatch(String agencyId) {
    return call(() async {
      final result = await apiService.getDetailsDriverDispatch(
          agencyId, "Bearer ${LocalStorage.accessToken.val}");

      if (result.status == RemoteDataContants.successStatus) {
        DriverInforDisptachResponse response =
            DriverInforDisptachResponse.fromJson(result.data);
        return AgencyMapper.converInforDriverDispatch(response);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDriverLocation(String driverId) {
    return call(() async {
      final result = await apiService.getDriverLocation(driverId, "Bearer ${LocalStorage.accessToken.val}");
      print(result);
      if(result.status == RemoteDataContants.successStatus) {
        DriverLocationResponse response = DriverLocationResponse.fromJson(result.data["driver_location"]);
        return AgencyMapper.convertDriverLocation(response);
      }else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getDetailsDriverA4(String driverId) {
    return call(() async {
      final result = await apiService.getDetailsDriverA4(driverId, "Bearer ${LocalStorage.accessToken.val}");
      print(result);
      if(result.status == RemoteDataContants.successStatus) {
        DriverInfoResponse response = DriverInfoResponse.fromJson(result.data);
        return DriverMapper.convertDriverInfo(response);
      }else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }

  @override
  Future<Either<Exception, dynamic>> getSalaryStatistic(
      Map<String, dynamic> params) {
    return call(() async {
      final result = await apiService.getSalaryStatistic(
          params, "Bearer ${LocalStorage.accessToken.val}");
      print(result);
      if (result.status == RemoteDataContants.successStatus) {
        List<SalaryStatisticResponse> response =
            List<SalaryStatisticResponse>.from(result.data
                .map((e) => SalaryStatisticResponse.fromJson(e))
                .toList());
        return AgencyMapper.convertListSalarySta(response);
      } else {
        final error = result.message;
        return Left(ApiError(error));
      }
    });
  }
}
