import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/delivery/deliveryrequestscontroller.dart';
import 'package:sire/core/constant/color.dart';

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
                              color: Appcolor.berry.withOpacity(0.2),
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
                      _buildInfoRow(
                        Icons.person,
                        controller.undeliveredOrders[index].userName ?? 'N/A',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.phone,
                        controller.undeliveredOrders[index].userPhone ?? 'N/A',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.access_time,
                        Jiffy.parse(controller
                                    .undeliveredOrders[index].orderDatetime ??
                                '')
                            .fromNow(),
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.location_on,
                        controller.undeliveredOrders[index].addressBymap ??
                            'N/A',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.directions_car,
                        'Delivery time: ${controller.undeliveredOrders[index].addressDeliverytime ?? 'N/A'}',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildPriceTag(
                              'Total',
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

  Widget _buildInfoRow(IconData icon, String text, {int maxLines = 1}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceTag(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$$value',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
