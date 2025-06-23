import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/controller/delivery/deliveredcontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/delivery/infoitemwidget.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveredControllerImp controller;
  final int index;

  const DeliveryCard({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final delivery = controller.delivered[index];
    final deliveryTime = Jiffy.parse(delivery.deliveryDatetime!).fromNow();
    final paymentType = controller.getPaymentType(delivery.orderPaymenttype!);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.goToOrderDetails(
              delivery.orderId.toString(),
              index,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with order ID and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '#${delivery.orderId}',
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                size: 14,
                                color: Colors.green[700],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Delivered',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      deliveryTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Order details row
                Row(
                  children: [
                    // Total price
                    Expanded(
                      child: InfoItemWidget(
                        icon: Icons.attach_money,
                        iconColor: Colors.green,
                        label: 'Total Amount',
                        value: '\$${delivery.orderTotalprice}',
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Payment method
                    Expanded(
                      child: InfoItemWidget(
                        icon: controller.getPaymentIcon(paymentType),
                        iconColor: Colors.orange,
                        label: 'Payment',
                        value: paymentType,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // View details button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.goToOrderDetails(
                        delivery.orderId.toString(),
                        index,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolor.berry,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility_outlined, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'View Order Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

