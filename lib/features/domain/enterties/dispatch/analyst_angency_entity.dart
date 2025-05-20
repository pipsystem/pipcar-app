// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnalystAgencyEntity {
  final double revenue;
  final double cost;
  final double profit;
  final int currentMonth;
  AnalystAgencyEntity({
    required this.revenue,
    required this.cost,
    required this.profit,
    required this.currentMonth,
  });
}

class AnalystExpenseEntity {
  final List<SalaryItemDriver> driverSalaryList;
  final double totalSalary;
  final double totalTicketCost;
  final double otherCost;
  AnalystExpenseEntity({
    required this.driverSalaryList,
    required this.totalSalary,
    required this.totalTicketCost,
    required this.otherCost,
  });

  factory AnalystExpenseEntity.empty() => AnalystExpenseEntity(
      driverSalaryList: [],
      totalSalary: -1,
      totalTicketCost: -1,
      otherCost: -1);
}

class SalaryItemDriver {
  final String agencyId;
  final String driverName;
  final String driverPhone;
  final double driverSalary;
  SalaryItemDriver({
    required this.agencyId,
    required this.driverName,
    required this.driverPhone,
    required this.driverSalary,
  });
}
