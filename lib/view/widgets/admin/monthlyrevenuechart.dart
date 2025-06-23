
import 'package:flutter/material.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/graph.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/chartcontainer.dart';
import 'package:sire/view/widgets/admin/emptychart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyRevenueChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const MonthlyRevenueChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardInfo.salesOverMonth == null ||
        controller.dashboardInfo.salesOverMonth!.isEmpty) {
      return EmptyChart(title: 'Monthly Revenue');
    }

    final revenueData = controller.dashboardInfo.salesOverMonth!
        .map((item) => RevenueData(
              item.monthShort ?? '',
              double.tryParse(item.totalSales ?? '0') ?? 0,
            ))
        .toList();

    return ChartContainer(
      title: 'Monthly Revenue',
      subtitle: 'Revenue trends over months',
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
            ColumnSeries<RevenueData, String>(
              dataSource: revenueData,
              xValueMapper: (RevenueData data, _) => data.month,
              yValueMapper: (RevenueData data, _) => data.amount,
              color: Appcolor.berry.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              width: 0.6,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              gradient: LinearGradient(
                colors: [
                  Appcolor.berry.withValues(alpha: 0.8),
                  Appcolor.berry.withValues(alpha: 0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}