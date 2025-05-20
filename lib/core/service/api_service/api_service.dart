import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../common/configs/constants/app_constant.dart';
import 'base_response/base_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppConstant.BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/app/monitor/auth')
  Future<BaseResponse> trackingAuth(@Queries() Map<String, dynamic> params, @Body() Map<String, dynamic> body);

  // Agency Authenticaiton
  @POST('/app/auth/pip/login')
  Future<BaseResponse> login(@Body() Map<String, dynamic> body);

  @POST('/app/auth/pip/refresh_token')
  Future<BaseResponse> checkRT(@Body() Map<String, dynamic> body);

  @POST('/app/auth/pip/logout')
  Future<BaseResponse> logOut(@Header('Authorization') String token);

  @GET('/app/agency/info_new')
  Future<BaseResponse> getAngencyInfor(@Header('Authorization') String token);

  @GET('/app/agency/block')
  Future<BaseResponse> blockAccount(@Header('Authorization') String token);

  @GET('/address')
  Future<BaseResponse> getAddress(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/address/search')
  Future<BaseResponse> getAddressSearch(@Queries() Map<String, dynamic> params);

  @GET('/app/agency/search')
  Future<BaseResponse> getListAgencySearch(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/agency/cash_get_phone')
  Future<BaseResponse> getPhoneAgency(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @POST('/app/agency/update_device')
  Future<BaseResponse> updateDeviceId(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  /// Car management
  @GET('/app/agency/car')
  Future<BaseResponse> getListCar(@Header('Authorization') String token);

  @DELETE('/app/car/delete')
  Future<BaseResponse> deleteCar(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @POST('/app/car/create')
  Future<BaseResponse> addCar(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  ///Driver management
  @GET('/app/agency/driver')
  Future<BaseResponse> getListDriver(@Header('Authorization') String token);

  @GET('/app/erp/agency/driver_list')
  Future<BaseResponse> getListDriverA4(@Header('Authorization') String token);

  @GET('/app/erp/agency/car_undriven')
  Future<BaseResponse> getListCarUndriven(
      @Header('Authorization') String token);

  @PUT('/app/agency/driver/undeliver')
  Future<BaseResponse> undeliverCar(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/agency/driver/deliver')
  Future<BaseResponse> deliverCar(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @GET('/app/agency/delivering/driver_list')
  Future<BaseResponse> driverDelivering(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @PUT('/app/agency/gps')
  Future<BaseResponse> updateGPS(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @POST('/app/agency/driver')
  Future<BaseResponse> addDriver(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @DELETE('/app/agency/driver/delete')
  Future<BaseResponse> deleteDriver(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @GET('/app/agency/delivering/detail/{agencyId}')
  Future<BaseResponse> getDetailsDriverDispatch(
      @Path() String agencyId, @Header('Authorization') String token);

  @GET('/app/erp/agency/driver/{driverId}')
  Future<BaseResponse> getDetailsDriverA4(
    @Path() String driverId, @Header('Authorization') String token
  );

  @GET('/app/erp/agency/driver_location/{driverId}')
  Future<BaseResponse> getDriverLocation(
    @Path() String driverId, @Header('Authorization') String token
  );

  ///________________________________ ticket owner ___________________________________
  ///
  ///
  @POST('/app/ticket')
  Future<BaseResponse> createTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @POST('/app/ticket/new_navigate')
  Future<BaseResponse> createTicketNavigate(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @GET('/app/ticket/owner/pass_list')
  Future<BaseResponse> getPassList(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/owner/accepted_list')
  Future<BaseResponse> getAcceptedList(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/owner/complete_list')
  Future<BaseResponse> getCompleteList(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/owner/process_list')
  Future<BaseResponse> getProcessList(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/owner/pass_detail/{ticketId}')
  Future<BaseResponse> getDetailsPassTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/owner/accepted_detail/{ticketId}')
  Future<BaseResponse> getDetailsAcceptedTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/owner/complete_detail/{ticketId}')
  Future<BaseResponse> getDetailsCompleteTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/owner/process_detail/{ticketId}')
  Future<BaseResponse> getDetailsProcessTicket(
      @Path() String ticketId, @Header('Authorization') String token);


  @PUT('/app/ticket/cancel')
  Future<BaseResponse> cancelTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/ticket/accept')
  Future<BaseResponse> acceptTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/ticket/complete')
  Future<BaseResponse> completeTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/ticket/update_customer_info')
  Future<BaseResponse> updateTicketCustomer(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  ///____________________ ticket supplier _____________________
  ///
  ///
  @GET('/app/ticket/supplier/new_list')
  Future<BaseResponse> getNewSchedule(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/new_detail/{ticketId}')
  Future<BaseResponse> getDetailsNewTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/supplier/apply_list')
  Future<BaseResponse> getTicketsApply(@Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/apply_detail/{ticketId}')
  Future<BaseResponse> getDetailsApplyTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/supplier/accepted_list')
  Future<BaseResponse> getMyAcceptedSchedules(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/accepted_detail/{ticketId}')
  Future<BaseResponse> getDetailsMyAcceptedTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/supplier/current_accepted')
  Future<BaseResponse> getCurrentAcceptedTicket(
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/drop_off_list')
  Future<BaseResponse> getDropOffSchedules(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/drop_off_detail/{ticketId}')
  Future<BaseResponse> getDetailsDropOffTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @GET('/app/ticket/supplier/complete_list')
  Future<BaseResponse> getMyCompleteSchedules(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/ticket/supplier/complete_detail/{ticketId}')
  Future<BaseResponse> getDetailsMyCompleteTicket(
      @Path() String ticketId, @Header('Authorization') String token);

  @PUT('/app/ticket/apply')
  Future<BaseResponse> applyTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/ticket/cancel_apply')
  Future<BaseResponse> cancelApplyTicket(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  @PUT('/app/ticket/supplier/drop_off/{ticketId}')
  Future<BaseResponse> dropOff(
      @Path() String ticketId, @Header('Authorization') String token);

  @PUT('/app/ticket/supplier/pick_up/{ticketId}')
  Future<BaseResponse> pickUp(
      @Path() String ticketId, @Header('Authorization') String token);

  @PUT('/app/ticket/cancel_navigate')
  Future<BaseResponse> deleteTicketNavigate(
      @Body() Map<String, dynamic> body, @Header('Authorization') String token);

  ///____________________ ticket supplier _____________________
  ///
  ///
  @GET('/app/agency/transaction_coin')
  Future<BaseResponse> getListTransaction(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);

  @GET('/app/agency/transaction_coin/detail/{transactionId}')
  Future<BaseResponse> getDetailsTransaction(
      @Path() String transactionId, @Header('Authorization') String token);

  ///--------------------- customer ---------------------------

  @GET('/app/agency/customer_list')
  Future<BaseResponse> getListCustomer(@Header('Authorization') String token);

  ///--------------------- Statistic ---------------------------

  @GET('/app/agency/delivering/analyst')
  Future<BaseResponse> getInforAnalyst(@Header('Authorization') String token);

  @GET('/app/transportation/manage/cost_statistic')
  Future<BaseResponse> getInforAnalystExpense(
      @Header('Authorization') String token);

  @GET('/app/transportation/manage/year_statistic')
  Future<BaseResponse> getSalaryStatistic(
      @Queries() Map<String, dynamic> params,
      @Header('Authorization') String token);
}
