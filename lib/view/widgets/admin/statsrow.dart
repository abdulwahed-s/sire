import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/view/widgets/admin/statcard.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) => SizedBox(
        height: 300,
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.6,
          children: controller.statusRequest == StatusRequest.loding
              ? [
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(elevation: 2)),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(elevation: 2)),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(elevation: 2)),
                  Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(elevation: 2)),
                ]
              : [
                  StatCard(
                      title: 'Total Sales',
                      value: '\$${controller.dashboardInfo.sales}',
                      icon: Iconsax.wallet,
                      color: Colors.blue),
                  StatCard(
                      title: 'Orders',
                      value: '${controller.dashboardInfo.order}',
                      icon: Iconsax.shopping_cart,
                      color: Colors.green),
                  StatCard(
                      title: 'Products',
                      value: '${controller.dashboardInfo.items}',
                      icon: Iconsax.shop,
                      color: Colors.orange),
                  StatCard(
                      title: 'Customers',
                      value: '${controller.dashboardInfo.customer}',
                      icon: Iconsax.profile_2user,
                      color: Colors.purple),
                ],
        ),
      ),
    );
  }
}
