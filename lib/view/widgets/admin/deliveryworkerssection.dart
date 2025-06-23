
import 'package:flutter/material.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/graph.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/chartcontainer.dart';
import 'package:sire/view/widgets/admin/emptychart.dart';
import 'package:sire/view/widgets/admin/workeravatar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DeliveryWorkersSection extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const DeliveryWorkersSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.dashboardInfo.deliveryWorkers == null ||
        controller.dashboardInfo.deliveryWorkers!.isEmpty) {
      return EmptyChart(title: 'Delivery Workers Performance');
    }

    final workerData = controller.dashboardInfo.deliveryWorkers!
        .map((worker) => DeliveryWorkerData(
              worker.userName ?? '',
              worker.numberOfOrders ?? 0,
              AppLink.pfpimage + (worker.userPfp ?? ''),
            ))
        .toList();

    return ChartContainer(
      title: 'Delivery Workers Performance',
      subtitle: 'Orders completed by each worker',
      chart: Column(
        children: [
          SizedBox(
            height: 250,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                isVisible: false,
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
                ColumnSeries<DeliveryWorkerData, String>(
                  dataSource: workerData,
                  xValueMapper: (data, _) => data.userName,
                  yValueMapper: (data, _) => data.numberOfOrders,
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
          const SizedBox(height: 16),
          WorkerAvatars(workerData: workerData),
        ],
      ),
    );
  }
}

class WorkerAvatars extends StatelessWidget {
  final List<DeliveryWorkerData> workerData;

  const WorkerAvatars({super.key, required this.workerData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
              workerData.map((worker) => WorkerAvatar(worker: worker)).toList(),
        ),
      ),
    );
  }
}