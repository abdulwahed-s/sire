import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/delivery/acceptedorderscontroller.dart';
import 'package:sire/controller/delivery/deliveryrequestscontroller.dart';
import 'package:sire/view/screens/delivery/acceptedorders.dart';
import 'package:sire/view/screens/delivery/deliveryrequests.dart';

abstract class DeliveryHomeController extends GetxController {
  void removeController(int i);
  void changePage(int i);
}

class DeliveryHomeControllerImp extends DeliveryHomeController {
  int currentpage = 0;
  List<Widget> listpages = [
    DeliveryRequests(),
    AcceptedOrders(),
  ];
  List<String> namepages = [
    "Pending Delivery",
    "Accepted Orders",
  ];
  List<IconData> iconpages = [
    Icons.local_shipping,
    Icons.assignment_turned_in,
  ];

  List<Type> controllerPages = [
    DeliveryRequestsControllerImp,
    AcceptedOrdersController,
  ];

  @override
  removeController(i) {
    for (int j = 0; j < controllerPages.length; j++) {
      if (j != i) {
        final type = controllerPages[j];
        if (type == DeliveryRequestsControllerImp) {
          Get.delete<DeliveryRequestsControllerImp>();
        } else if (type == AcceptedOrdersController) {
          Get.delete<AcceptedOrdersController>();
        }
      }
    }
  }

  @override
  changePage(i) {
    currentpage = i;
    removeController(i);
    update();
  }

  @override
  void onInit() {
    currentpage = Get.arguments?['num'] ?? 0;
    super.onInit();
  }
}
