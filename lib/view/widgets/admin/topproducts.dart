import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';

class TopProducts extends StatelessWidget {
  const TopProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
        children: controller.statusRequest == StatusRequest.loding
            ? [
                Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      elevation: 2,
                    )),
                Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Card(
                      elevation: 2,
                    ))
              ]
            : controller.dashboardInfo.topProducts!.map((product) {
                return Card(
                  color: Appcolor.white,
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  AppLink.itemimage + product.itemImg!),
                              fit: BoxFit.contain,
                            ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.itemName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                                "${product.itemPrice! + (product.itemDiscount! / 100) + product.itemPrice!}\$"),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Iconsax.shopping_cart, size: 14),
                                const SizedBox(width: 4),
                                Text('${product.totalSold} sold'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
      ),
    );
  }
}