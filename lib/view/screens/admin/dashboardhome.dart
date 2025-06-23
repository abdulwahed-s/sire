import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/view/widgets/admin/admingraph.dart';
import 'package:sire/view/widgets/admin/recentorders.dart';
import 'package:sire/view/widgets/admin/statsrow.dart';
import 'package:sire/view/widgets/admin/topproducts.dart';

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminDashboardControllerImp());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminGraph(),
          const Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          StatsRow(),
          const Text(
            'Recent Orders',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          RecentOrders(),
          const SizedBox(height: 24),
          const Text(
            'Top Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TopProducts(),
        ],
      ),
    );
  }
}
