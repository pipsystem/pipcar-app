import 'package:pipcar/features/domain/enterties/customer/customer_entity.dart';

import '../models/customers/customers_response.dart';

class CustomersMapper {
  static List<CustomersEntity> fromListCustomersResponse(
      List<CustomersResponse> response) {
    return response
        .map((e) => CustomersEntity(
            customer_phone: e.customerPhone ?? "",
            customer_name: e.customerName ?? "",
            total_completetd_ticket: e.totalCompletedTicket ?? 0))
        .toList();
  }
}
