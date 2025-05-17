import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sire/controller/delivery/acceptedorderscontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/delivery/Statusbadge.dart';
import 'package:sire/view/widgets/delivery/detailitem.dart';
import 'package:sire/view/widgets/delivery/inforow.dart';

class OrderCard extends StatelessWidget {
  final AcceptedOrdersControllerImp controller;
  final int index;
  final String status;
  final Color statusColor;

  const OrderCard({
    super.key,
    required this.controller,
    required this.index,
    this.status = 'In Progress',
    this.statusColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    final order = controller.acceptedOrders[index];
    final formattedDate = order.orderDatetime != null
        ? DateFormat('MMM dd, yyyy - hh:mm a')
            .format(DateTime.parse(order.orderDatetime!))
        : 'N/A';

    return Card(
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
                  'Order #${order.orderId}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StatusBadge(
                  status: status,
                  color: statusColor,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Info
            InfoRow(
              icon: Icons.person,
              text: order.userName ?? 'N/A',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.phone,
              text: order.userPhone ?? 'N/A',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.location_on,
              text: order.addressBymap ?? 'N/A',
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.access_time,
              text: order.addressDeliverytime ?? 'N/A',
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            InfoRow(
              icon: Icons.payment,
              text: controller.getPaymentType(order.orderPaymenttype!),
              maxLines: 1,
            ),
            const SizedBox(height: 12),

            // Order Summary
            Row(
              children: [
                Expanded(
                  child: DetailItem(
                    label: 'Date',
                    value: formattedDate,
                    isPrice: false,
                  ),
                ),
                Expanded(
                  child: DetailItem(
                    label: 'Total',
                    value:
                        '\$${order.orderTotalprice?.toStringAsFixed(2) ?? '0.00'}',
                    isPrice: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                // Details Button
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Appcolor.amaranthpink,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () => controller.goToOrderDetails(
                            order.orderId.toString(), index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.remove_red_eye_outlined,
                                  size: 20, color: Appcolor.berry),
                              const SizedBox(width: 8),
                              Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Appcolor.berry,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Deliver Button
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(8),
                    color: Appcolor.berry,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => controller.markAsDelivered(
                        order.orderUserid.toString(),
                        order.orderId.toString(),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 20, color: Colors.white),
                            const SizedBox(width: 8),
                            Text(
                              'Mark As Delivered',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
