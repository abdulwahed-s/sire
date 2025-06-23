import 'package:flutter/material.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/graph.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/chartcontainer.dart';
import 'package:sire/view/widgets/admin/emptychart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesOverTimeChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const SalesOverTimeChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardInfo.salesOverWeek == null ||
        controller.dashboardInfo.salesOverWeek!.isEmpty) {
      return const EmptyChart(title: 'Sales Over Time');
    }

    final salesData = controller.dashboardInfo.salesOverWeek!
        .map((item) => SalesData(
              item.dayName ?? '',
              double.tryParse(item.totalSales ?? '0') ?? 0,
            ))
        .toList();

    return ChartContainer(
      title: 'Sales Over Time',
      subtitle: 'Weekly performance overview',
      chart: SizedBox(
        height: 280,
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          primaryYAxis: NumericAxis(
            majorGridLines: MajorGridLines(
              width: 1,
              color: Colors.grey[200]!,
            ),
            axisLine: const AxisLine(width: 0),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          plotAreaBorderWidth: 0,
          series: <CartesianSeries>[
            LineSeries<SalesData, String>(
              dataSource: salesData,
              xValueMapper: (SalesData data, _) => data.day,
              yValueMapper: (SalesData data, _) => data.sales,
              color: Appcolor.berry,
              width: 3,
              markerSettings: const MarkerSettings(
                isVisible: true,
                color: Appcolor.berry,
                borderColor: Colors.white,
                borderWidth: 2,
                height: 8,
                width: 8,
              ),
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}