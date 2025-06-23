
import 'package:flutter/material.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/graph.dart';
import 'package:sire/view/widgets/admin/chartcontainer.dart';
import 'package:sire/view/widgets/admin/emptychart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderStatusChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const OrderStatusChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardInfo.ordersNumber == null ||
        controller.dashboardInfo.ordersNumber!.isEmpty) {
      return EmptyChart(title: 'Order Status');
    }

    final orderStatusData = controller.dashboardInfo.ordersNumber!
        .map((status) => OrderStatusData(
              controller.getStatusText(status.orderStatus!),
              status.ordersNumber?.toDouble() ?? 0,
            ))
        .toList();

    return ChartContainer(
      title: 'Order Status',
      subtitle: 'Current order distribution',
      chart: SizedBox(
        height: 300,
        child: SfCircularChart(
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            textStyle: const TextStyle(fontSize: 12),
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <DoughnutSeries<OrderStatusData, String>>[
            DoughnutSeries<OrderStatusData, String>(
              dataSource: orderStatusData,
              xValueMapper: (OrderStatusData data, _) => data.status,
              yValueMapper: (OrderStatusData data, _) => data.percent,
              radius: '80%',
              innerRadius: '50%',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.outside,
                connectorLineSettings: ConnectorLineSettings(
                  type: ConnectorType.curve,
                  length: '20%',
                ),
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
