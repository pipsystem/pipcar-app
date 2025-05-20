import 'package:pipcar/common/utils/utils_src.dart';
import 'package:pipcar/features/data/models/agency/address_search_response.dart';
import 'package:pipcar/features/data/models/agency/phone_response.dart';
import 'package:pipcar/features/data/models/dispatch/analyst_response.dart';
import 'package:pipcar/features/data/models/driver/driver_location_response.dart';
import 'package:pipcar/features/domain/enterties/agency/agency_search_infor_entity.dart';
import 'package:pipcar/features/domain/enterties/dispatch/analyst_angency_entity.dart';
import 'package:pipcar/features/domain/enterties/driver_location_entity.dart';

import '../../domain/enterties/dispatch/infor_driver_dispatch_entity.dart';
import '../../domain/enterties/dispatch/salary_statistic_entity.dart';
import '../../domain/enterties/entities.dart';
import '../models/dispatch/analyst_expense_response.dart';
import '../models/dispatch/infor_driver_dispatch_response.dart';
import '../models/dispatch/salary_statistic__response.dart';
import '../models/models.dart';

class AgencyMapper {
  static AgencyInforEntity fromAgencyInforResponse(
      AgencyInforResponse? response) {
    return AgencyInforEntity(
        agencyId: response?.agencyId ?? "",
        name: response?.name ?? "",
        phone: response?.phone ?? "unknow",
        isTransportation: response?.isTransportation ?? false,
        isDriver: response?.isDriver ?? false,
        coin: response?.coin ?? 0,
        point: response?.point ?? 0,
        carTypeId: response?.carTypeId ?? 0,
        agencyType: response?.agencyType ?? "A1");
  }

  static AgencySearchEntity fromAgencySearchResponse(
      AgencySearchResponse response) {
    return AgencySearchEntity(
      rank: response.rank ?? 0,
      carName: response.carName ?? "",
      carPlates: response.carPlates ?? "",
      agencyId: response.agencyId ?? "",
      id: response.carId ?? "",
      carLat: response.carLat ?? "",
      carLong: response.carLong ?? "",
      avatar: response.avatar ?? "",
      timeUpdate: response.updatedGpsTime ?? "",
      distance1: response.distance1 ?? "",
      distance: response.distance ?? 0,
      carTypeName: '',
    );
  }

  static AgencySearchInforEntity fromGetPhoneRespone(PhoneResponse response) {
    return AgencySearchInforEntity(
      phone: response.phone ?? "",
      agencyName: response.agencyName ?? "",
      carLat: response.carLat ?? "",
      carLong: response.carLong ?? "",
      updatedGpsTime: response.updatedGpsTime ?? "",
    );
  }

  static DistrictEntity fromDistrictResponse(DistrictResponse response) {
    return DistrictEntity(
      id: response.id ?? "",
      name: response.name?.replaceAll("Quận", "").trim() ?? "",
      provinceId: response.provinceId ?? "",
      centerLat: response.centerLat ?? 0,
      centerLong: response.centerLong ?? 0,
      status: response.status ?? 0,
      priority: response.priority ?? 0,
    );
  }

  static ProvinceEntity fromProvinceResponse(ProvinceResponse response) {
    return ProvinceEntity(
        id: response.id ?? "",
        name: response.name ?? "",
        provinceId: response.provinceId ?? "",
        status: response.status ?? 0,
        priority: response.priority ?? 1);
  }

  static ProvinceEntity fromProvinceSearchResponse(AddressSearchResponse response) {
    return ProvinceEntity(
        id: response.id ?? "",
        name: response.addressName ?? "",
        provinceId: response.provinceId ?? "",
        status: 0,
        priority: 1);
  }

  static DistrictEntity fromDistrictSearchResponse(AddressSearchResponse response) {
    return DistrictEntity(
      id: response.id ?? "",
      name: response.addressName?.replaceAll("Quận", "").trim() ?? "",
      provinceId: response.provinceId ?? "",
      centerLat: 0,
      centerLong: 0,
      status: 0,
      priority: 0,
    );
  }

  static AnalystAgencyEntity converAnalyst(AnalystResponse response) {
    return AnalystAgencyEntity(
        revenue: response.revenue ?? 0,
        cost: response.cost ?? 0,
        profit: response.profit ?? 0,
        currentMonth: response.currentMonth ?? 0);
  }

  static List<SalaryStatisticEntity> convertListSalarySta(
      List<SalaryStatisticResponse> response) {
    return List<SalaryStatisticEntity>.from(response.map((e) =>
        SalaryStatisticEntity(
            month: e.month ?? 0,
            totalSalary: e.totalSalary ?? 0,
            profit: e.profit ?? 0)));
  }

  static InforDriverDispatchEntity converInforDriverDispatch(
      DriverInforDisptachResponse response) {
    return InforDriverDispatchEntity(
        agencyId: response.agencyId ?? '',
        driverName: response.driverName ?? '',
        driverPhone: response.driverPhone ?? '',
        carPlate: response.carPlate ?? '',
        carName: response.carName ?? '',
        carTypeName: response.carTypeName ?? '',
        carTypeId: response.carTypeId ?? 0,
        currentMonth: response.currentMonth ?? 0,
        ticketId: response.currentTicket?.ticketId,
        pickUpTime: response.currentTicket?.pickpTime,
        desciptionCurrentTicket: response.currentTicket?.description);
  }

  static DriverLocationEntity convertDriverLocation(DriverLocationResponse response) {
    return DriverLocationEntity(lat: response.lat ?? '', long: response.long ?? '', updateTime: response.updatedGpsTime ?? 0, distance: response.distance ?? 0);
  }

  static AnalystExpenseEntity convertExpenseAnalyst(
      AnalystExpenseResponse response) {
    return AnalystExpenseEntity(
        driverSalaryList: isNullEmpty(response.driverSalaryList)
            ? <SalaryItemDriver>[]
            : response.driverSalaryList!
                .map((e) => SalaryItemDriver(
                    agencyId: e.agencyId ?? '',
                    driverName: e.driverName ?? '',
                    driverPhone: e.driverPhone ?? '',
                    driverSalary: e.driverSalary ?? 0))
                .toList(),
        totalSalary: response.totalSalary ?? 0,
        totalTicketCost: response.totalTicketCost ?? 0,
        otherCost: response.otherCost ?? 0);
  }
}
