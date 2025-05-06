import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/orders/ArchivedOrdersController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/orders/detailrow.dart';

class ArchivedOrders extends StatelessWidget {
  const ArchivedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArchivedOrdersControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Orders'),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<ArchivedOrdersControllerImp>(
        builder: (controller) => ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: controller.archivedOrders.length,
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
                  // Header with status and time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(
                          'Archived',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: Colors.grey.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      Text(
                        Jiffy.parse(
                                controller.archivedOrders[index].orderDatetime!)
                            .fromNow(),
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Order details
                  DetailRow(
                    isTotal: false,
                    label: 'Delivery Price:',
                    value:
                        '${controller.archivedOrders[index].orderPricedelivery}',
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Order Price:',
                    value: '${controller.archivedOrders[index].orderPrice}',
                  ),
                  DetailRow(
                    label: 'Total Price:',
                    value:
                        '${controller.archivedOrders[index].orderTotalprice}',
                    isTotal: true,
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Payment Type:',
                    value: controller.getPaymentType(
                        controller.archivedOrders[index].orderPaymenttype!),
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Order Type:',
                    value: controller.getOrderType(
                        controller.archivedOrders[index].orderType!),
                  ),

                  const SizedBox(height: 12),

                  // Details button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle order details
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.amaranthpink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Order Details',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
