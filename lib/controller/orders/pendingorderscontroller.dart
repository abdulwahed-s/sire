import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/orders/orderdata.dart';
import 'package:sire/data/model/ordersmodel.dart';
import 'package:sire/view/screens/orders/orderdetails.dart';

abstract class PendingOrdersController extends GetxController {
  getPendingOrders();
  Color getStatusColor(int? statusCode);
  String getStatusText(int? statusCode);
  String getPaymentType(int paymentCode);
  String getOrderType(int typeCode);
  getOrderDetails(String orderid);
  cancelorder(String orderid);
}

class PendingOrdersControllerImp extends PendingOrdersController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  OrderData orderData = OrderData(Get.find());

  List<OrdersModel> pendingOrders = [];

  @override
  getPendingOrders() async {
    statusRequest = StatusRequest.loding;
    pendingOrders.clear();
    var response = await orderData
        .getPendingOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        pendingOrders.addAll(
          data.map(
            (e) => OrdersModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getPendingOrders();
    super.onInit();
  }

  @override
  getStatusColor(statusCode) {
    switch (statusCode) {
      case 0:
        return Colors.orange; // Pending - waiting seller approval
      case 1:
        return Colors.blue; // Working on it
      case 2:
        return Colors.lightBlue; // On the way/delivery
      case 3:
        return Colors.green; // Delivered
      case 4:
        return Colors.purple; // Waiting for customer pickup
      case 5:
        return Colors.green; // Waiting for customer pickup
      case -1:
        return Colors.red; // Cancelled
      default:
        return Colors.grey; // Unknown status
    }
  }

  @override
  getStatusText(statusCode) {
    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case 2:
        return 'On The Way';
      case 3:
        return 'Delivered';
      case 4:
        return 'Ready for Pickup';
      case 5:
        return 'User Picked Up';
      case -1:
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }

  @override
  getPaymentType(paymentCode) {
    switch (paymentCode) {
      case 0:
        return 'Visa';
      case 1:
        return 'Master Card';
      case 2:
        return 'American Express';
      case 3:
        return 'PayPal';
      case 4:
        return 'Cash';
      default:
        return 'Unknown Payment Method';
    }
  }

  @override
  getOrderType(typeCode) {
    switch (typeCode) {
      case 0:
        return 'Delivery';
      case 1:
        return 'Pick Up';
      default:
        return 'Unknown Order Method';
    }
  }

  @override
  getOrderDetails(orderid) {
    Get.to(
      () => OrderDetails(),
      arguments: {"orderid": orderid},
    );
  }

  @override
  cancelorder(orderid) async {
    statusRequest = StatusRequest.loding;
    var response = await orderData.cancelorder(orderid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        print("done");
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    getPendingOrders();
    update();
  }
}
