import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/admin/orders/manageorderscontroller.dart';
import 'package:sire/view/widgets/admin/ActionButtons.dart';

class OrderCard extends StatelessWidget {
  final ManageOrdersControllerImp controller;
  final int index;
  const OrderCard({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final order = controller.orders[index];
    final statusText =
        controller.getStatusText(order.orderStatus!, order.orderType!);
    final statusColor = controller.getStatusColor(order.orderStatus!);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      child: InkWell(
        onTap: () {
          controller.goToOrderDetails(
              controller.orders[index].orderId.toString(), index);
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order.orderId}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Order details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.userName ?? 'No Name',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.userEmail ?? 'No Email',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          order.userPhone ?? 'No Phone',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Placed ${Jiffy.parse(order.orderDatetime!).fromNow()}",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  // User avatar
                  if (order.userPfp != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.pfpimage}${order.userPfp}",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 48,
                          height: 48,
                          color: Colors.grey[200],
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Payment and delivery info
              Row(
                children: [
                  Icon(
                    order.orderPaymenttype == 0
                        ? Icons.credit_card
                        : Icons.money,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.getPaymentType(order.orderPaymenttype!),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    order.orderType == 0 ? Icons.delivery_dining : Icons.store,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.getOrderType(order.orderType!),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Address info
              if (order.addressBymap != null || order.addressName != null)
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${order.addressName ?? ''}${order.addressName != null && order.addressBymap != null ? ' - ' : ''}${order.addressBymap ?? ''}",
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 12),

              // Price summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.couponCode != null)
                        Text(
                          "Coupon: ${order.couponCode!} (-${order.couponDiscount ?? 0})",
                          style:
                              TextStyle(color: Colors.green[700], fontSize: 12),
                        ),
                    ],
                  ),
                  Text(
                    "Total: \$${order.orderTotalprice?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Action buttons
              ActionButtons(
                controller: controller,
                order: order,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
