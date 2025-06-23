import 'package:flutter/material.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/graph.dart';
import 'package:sire/view/widgets/admin/chartcontainer.dart';
import 'package:sire/view/widgets/admin/emptychart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopCategoriesChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const TopCategoriesChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardInfo.topCategories == null ||
        controller.dashboardInfo.topCategories!.isEmpty) {
      return const EmptyChart(title: 'Top Selling Categories');
    }

    final categoryData = controller.dashboardInfo.topCategories!
        .map((category) => CategorySales(
              category.categoryName ?? '',
              category.totalSelling?.toDouble() ?? 0,
            ))
        .toList();

    return ChartContainer(
      title: 'Top Selling Categories',
      subtitle: 'Best performing product categories',
      chart: SizedBox(
        height: 300,
        child: SfCircularChart(
          legend: const Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: TextStyle(fontSize: 12),
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <PieSeries<CategorySales, String>>[
            PieSeries<CategorySales, String>(
              dataSource: categoryData,
              xValueMapper: (CategorySales data, _) => data.category,
              yValueMapper: (CategorySales data, _) => data.salesPercent,
              radius: '70%',
              explode: true,
              explodeIndex: 0,
              explodeOffset: '10%',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                textStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              enableTooltip: true,
            ),
          ],
        ),
      ),
    );
  }
}
