part of 'statistic_provider.dart';

class StatisticScreen extends StatelessWidget {
  const StatisticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var state = context.watch<StatisticExpenseCubit>().state;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Thống kê chi phí',
        titleStyle: ThemeText.appBar,
      ),
      body: state.detailExpense == null
          ? const Center(
              child: Text('Đã có lỗi xảy ra'),
            )
          : state.detailExpense?.totalSalary == -1
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColor.lightGrey,
                  strokeWidth: 1.5,
                ))
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.paddingHorizontalApp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height / 3,
                          child: Builder(builder: (context) {
                            var total = state.detailExpense!.totalSalary +
                                state.detailExpense!.totalTicketCost +
                                state.detailExpense!.otherCost;
                            final List<ChartData> chartData = [
                              ChartData(
                                  'Lương lái xe',
                                  state.detailExpense?.totalSalary ?? 0,
                                  (state.detailExpense?.totalSalary ?? 0) /
                                      total),
                              ChartData(
                                  'Bổ lịch',
                                  state.detailExpense?.totalTicketCost ?? 0,
                                  (state.detailExpense?.totalTicketCost ?? 0) /
                                      total),
                              ChartData(
                                  'Khác',
                                  state.detailExpense?.otherCost ?? 0,
                                  (state.detailExpense?.otherCost ?? 0) /
                                      total),
                            ];
                            return SfCircularChart(
                                legend: const Legend(isVisible: true),
                                palette: const <Color>[
                                  Color(0xff66B9FF),
                                  Color(0xffFF9AA2),
                                  Color(0xffFFB347),
                                ],
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CircularSeries>[
                                  // Render pie chart
                                  PieSeries<ChartData, String>(
                                      dataSource: chartData,
                                      selectionBehavior:
                                          SelectionBehavior(enable: true),
                                      enableTooltip: true,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelMapper: (ChartData data, _) =>
                                          data.percent.formatPercentage(),
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true,
                                              labelPosition:
                                                  ChartDataLabelPosition
                                                      .outside))
                                ]);
                          }),
                        ),
                        BlockListSalaryDriver(
                                analystExpense: state.detailExpense!)
                            .paddingBottom(10.h),
                        ItemCoinWidget(
                          prefixIcon: ImageAppWidget(
                            path: Assets.images.icFunGold.keyName,
                            width: 25.w,
                          ),
                          subTitle: "Chi phí bổ lịch",
                          coin: state.detailExpense?.totalTicketCost ?? 0,
                        ),
                        ItemCoinWidget(
                          prefixIcon: ImageAppWidget(
                            path: Assets.images.icFunGold.keyName,
                            width: 25.w,
                          ),
                          subTitle: "Chi phí khác",
                          coin: state.detailExpense?.otherCost ?? 0,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.percent);
  final String x;
  final double y;
  final double percent;
}
