// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'salary_month_statistic_provider.dart';

class SalaryStatisticScreen extends StatefulWidget {
  final String supplierId;
  const SalaryStatisticScreen({
    Key? key,
    required this.supplierId,
  }) : super(key: key);

  @override
  State<SalaryStatisticScreen> createState() => _SalaryStatisticScreenState();
}

class _SalaryStatisticScreenState extends State<SalaryStatisticScreen> {
  @override
  void initState() {
    context.read<SalaryMonthStatisticCubit>().getData(widget.supplierId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<SalaryMonthStatisticCubit>().state;

    return Scaffold(
      appBar: AppBarWidget(
        title: "Thu nhập",
        titleStyle: ThemeText.appBar,
      ),
      body: state.salarys == null
          ? const Center(
              child: Text('Đã có lỗi xảy ra'),
            )
          : state.salarys!.isEmpty
              ? const Center(
                  child: Text('Không có dữ liệu'),
                )
              : SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: Builder(builder: (context) {
                    final List<SalaryData> salary =
                        List<SalaryData>.generate(12, (index) {
                      var indexSalary = state.salarys!
                          .indexWhere((e) => e.month - 1 == index);
                      return SalaryData(
                          "${index + 1}",
                          indexSalary < 0
                              ? 0
                              : state.salarys![indexSalary].totalSalary);
                    });

                    final List<SalaryData> profit =
                        List<SalaryData>.generate(12, (index) {
                      var indexProfit = state.salarys!
                          .indexWhere((e) => e.month - 1 == index);
                      return SalaryData(
                          "${index + 1}",
                          indexProfit < 0
                              ? 0
                              : state.salarys![indexProfit].profit);
                    });

                    var totalSalary = 0.0;
                    for (var i in state.salarys!) {
                      totalSalary += i.totalSalary;
                    }

                    return Column(
                      children: [
                        SfCartesianChart(
                          title: ChartTitle(
                              alignment: ChartAlignment.far,
                              text:
                                  "Hiện tại: Tháng ${DateTime.now().month} năm ${DateTime.now().year}",
                              textStyle: ThemeText.note.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                  color: AppColor.grey)),
                          legend: const Legend(
                              isVisible: true,
                              position: LegendPosition.top,
                              itemPadding: 30),
                          enableSideBySideSeriesPlacement: false,
                          primaryXAxis: CategoryAxis(
                              title: AxisTitle(
                                  text: "Tháng", textStyle: ThemeText.note)),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true, maximumZoomLevel: 0.7),
                          primaryYAxis: NumericAxis(
                              title: AxisTitle(
                                  alignment: ChartAlignment.far,
                                  text: "coin",
                                  textStyle: ThemeText.note.copyWith(
                                      color: Colors.yellow[800],
                                      fontWeight: FontWeight.bold,
                                      height: 0.5))),
                          series: <ChartSeries>[
                            ColumnSeries<SalaryData, String>(
                                color: AppColor.blue,
                                name: "Lương",
                                dataSource: salary,
                                xValueMapper: (SalaryData sales, _) =>
                                    sales.month,
                                yValueMapper: (SalaryData sales, _) => sales.x,
                                dataLabelSettings: DataLabelSettings(
                                    textStyle:
                                        ThemeText.note.copyWith(fontSize: 8.sp),
                                    margin: EdgeInsets.zero,
                                    isVisible: true,
                                    opacity: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(2))),
                            ColumnSeries<SalaryData, String>(
                                color: AppColor.green2,
                                name: "Thu nhập",
                                opacity: 0.7,
                                dataSource: profit,
                                xValueMapper: (SalaryData sales, _) =>
                                    sales.month,
                                yValueMapper: (SalaryData sales, _) => sales.x,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(2))),
                          ],
                        ).expand(),
                        ItemCoinWidget(
                          prefixIcon: ImageAppWidget(
                            path: Assets.icons.iconWallet.keyName,
                            color: AppColor.primaryColor,
                            width: 25,
                          ).paddingSymmetric(horizontal: 5.w),
                          subTitle: "Lương trung bình",
                          coin:
                              (totalSalary / 12).toStringAsFixed(2).toDouble(),
                        ).paddingAll(AppDimens.paddingHorizontalApp),
                      ],
                    );
                  }),
                ),
    );
  }
}

class SalaryData {
  final String month;
  final double x;

  SalaryData(
    this.month,
    this.x,
  );
}
