import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/delivery/acceptedorderscontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/view/widgets/delivery/ordercard.dart';

class AcceptedOrders extends StatelessWidget {
  const AcceptedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AcceptedOrdersControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        centerTitle: true,
      ),
      body: GetBuilder<AcceptedOrdersControllerImp>(
        builder: (controller) {
          if (controller.statusRequest == StatusRequest.loding) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.acceptedOrders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delivery_dining,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active deliveries',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Accepted orders will appear here',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => controller.getAcceptedOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: controller.acceptedOrders.length,
              itemBuilder: (context, index) =>
                  OrderCard(controller: controller, index: index),
            ),
          );
        },
      ),
    );
  }
}
