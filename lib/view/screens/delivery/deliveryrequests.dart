import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/delivery/deliveryrequestscontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/delivery/buildInforow.dart';
import 'package:sire/view/widgets/delivery/buildpricetag.dart';

class DeliveryRequests extends StatelessWidget {
  const DeliveryRequests({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryRequestsControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Deliveries'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<DeliveryRequestsControllerImp>(
        builder: (controller) {
          if (controller.undeliveredOrders.isEmpty) {
            return const Center(
              child: Text(
                'No pending deliveries',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => await controller.getUndeliveredOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: controller.undeliveredOrders.length,
              itemBuilder: (context, index) => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${controller.undeliveredOrders[index].orderId}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Appcolor.berry.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              controller.getPaymentType(controller
                                  .undeliveredOrders[index].orderPaymenttype!),
                              style: TextStyle(
                                color: Appcolor.berry,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      BuildInfoRow(
                        icon: Icons.person,
                        text: controller.undeliveredOrders[index].userName ??
                            'N/A',
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      BuildInfoRow(
                          icon: Icons.phone,
                          text: controller.undeliveredOrders[index].userPhone ??
                              'N/A',
                          maxLines: 1),
                      const SizedBox(height: 8),
                      BuildInfoRow(
                        icon: Icons.access_time,
                        text: Jiffy.parse(controller
                                    .undeliveredOrders[index].orderDatetime ??
                                '')
                            .fromNow(),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      BuildInfoRow(
                        icon: Icons.location_on,
                        text:
                            controller.undeliveredOrders[index].addressBymap ??
                                'N/A',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      BuildInfoRow(
                        icon: Icons.directions_car,
                        text:
                            'Delivery time: ${controller.undeliveredOrders[index].addressDeliverytime ?? 'N/A'}',
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: BuildPriceTag(
                              value: 'Total',
                              label:
                                  '${controller.undeliveredOrders[index].orderTotalprice ?? 0}',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                controller.goToOrderDetails(
                                    controller.undeliveredOrders[index].orderId
                                        .toString(),
                                    index);
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                side: BorderSide(color: Appcolor.berry),
                              ),
                              child: const Text('View Details'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.acceptorder(
                                    controller
                                        .undeliveredOrders[index].orderUserid
                                        .toString(),
                                    controller.undeliveredOrders[index].orderId
                                        .toString());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolor.berry,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
