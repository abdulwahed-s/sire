import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/orders/pendingorderscontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/orders/detailrow.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PendingOrdersControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Orders'),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<PendingOrdersControllerImp>(
        builder: (controller) => ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: controller.pendingOrders.length,
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
                          controller.getStatusText(
                              controller.pendingOrders[index].orderStatus),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        backgroundColor: controller.getStatusColor(
                            controller.pendingOrders[index].orderStatus),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      Text(
                        Jiffy.parse(
                                controller.pendingOrders[index].orderDatetime!)
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
                        '${controller.pendingOrders[index].orderPricedelivery}',
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Order Price:',
                    value: '${controller.pendingOrders[index].orderPrice}',
                  ),
                  DetailRow(
                    label: 'Total Price:',
                    value: '${controller.pendingOrders[index].orderTotalprice}',
                    isTotal: true,
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Payment Type:',
                    value: controller.getPaymentType(
                        controller.pendingOrders[index].orderPaymenttype!),
                  ),
                  DetailRow(
                    isTotal: false,
                    label: 'Order Type:',
                    value: controller.getOrderType(
                        controller.pendingOrders[index].orderType!),
                  ),

                  const SizedBox(height: 12),

                  // Details button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            controller.getOrderDetails(
                              controller.pendingOrders[index].orderId!
                                  .toString(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Appcolor.amaranthpink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Appcolor.amaranthpink,
                                width: 1.5,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            elevation: 0,
                          ),
                          child: Text(
                            'Order Details',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (controller.pendingOrders[index].orderStatus! == 0)
                          SizedBox(width: 12),
                        if (controller.pendingOrders[index].orderStatus! == 0)
                          ElevatedButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "Cancel Order?",
                                titleStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red[700],
                                ),
                                middleText:
                                    "Are you sure you want to cancel this order?",
                                middleTextStyle: TextStyle(fontSize: 14),
                                backgroundColor: Colors.white,
                                radius: 12,
                                contentPadding: EdgeInsets.all(20),
                                actions: [
                                  // Cancel Button (No action - just closes dialog)
                                  ElevatedButton(
                                    onPressed: () => Get.back(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.berry,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    child: Text(
                                      "No, Keep It",
                                      style: TextStyle(
                                        color: Appcolor.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // Confirm Cancel Button
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.cancelorder(
                                        controller.pendingOrders[index].orderId!
                                            .toString(),
                                      );
                                      Get.back(); // Close the dialog
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    child: Text(
                                      "Yes, Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8), // Smaller padding
                            ),
                            child: Text(
                              'Cancel Order',
                              style: TextStyle(
                                fontSize: 13, // Slightly smaller text
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
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
