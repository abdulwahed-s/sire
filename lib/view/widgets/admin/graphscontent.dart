import 'package:flutter/material.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/view/widgets/admin/deliveryworkerssection.dart';
import 'package:sire/view/widgets/admin/monthlyrevenuechart.dart';
import 'package:sire/view/widgets/admin/orderstatuschart.dart';
import 'package:sire/view/widgets/admin/salesovertimechart.dart';
import 'package:sire/view/widgets/admin/topcategorieschart.dart';

class GraphsContent extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const GraphsContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SalesOverTimeChart(controller: controller),
          const SizedBox(height: 24),
          TopCategoriesChart(controller: controller),
          const SizedBox(height: 24),
          MonthlyRevenueChart(controller: controller),
          const SizedBox(height: 24),
          OrderStatusChart(controller: controller),
          const SizedBox(height: 24),
          DeliveryWorkersSection(controller: controller),
        ],
      ),
    );
  }
}