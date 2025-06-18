import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/delivery/deliverydata.dart';
import 'package:sire/data/model/itemdeliverymodel.dart';
import 'package:sire/view/screens/delivery/deliverynavigation.dart';

abstract class DeliveryOrderDetailsController extends GetxController {
  getOrderDetails();
  goToNavigation();
}

class DeliveryOrderDetailsControllerImp extends DeliveryOrderDetailsController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<ItemDeliveryModel> orderDetails = [];
  dynamic undeliveredOrders;
  String? orderid;

  bool? isDelivered = false;

  @override
  getOrderDetails() async {
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await deliveryData.getOrderDetails(orderid!);
    print(response);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        orderDetails.addAll(
          data.map(
            (e) => ItemDeliveryModel.fromJson(e),
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
    orderid = Get.arguments['orderid'];
    undeliveredOrders = Get.arguments['undeliveredOrder'];
    isDelivered = Get.arguments['isDelivered'];
    getOrderDetails();
    super.onInit();
  }

  Marker parseMarkerFromString(String markerString) {
    try {
      final latLngMatch =
          RegExp(r'LatLng\(([0-9.]+), ([0-9.]+)\)').firstMatch(markerString);
      if (latLngMatch == null) {
        throw const FormatException("Invalid LatLng in marker string");
      }

      final double lat = double.parse(latLngMatch.group(1)!);
      final double lng = double.parse(latLngMatch.group(2)!);
      final LatLng position = LatLng(lat, lng);

      final markerIdMatch =
          RegExp(r'MarkerId\(([0-9]+)\)').firstMatch(markerString);
      final String markerId = markerIdMatch?.group(1) ?? '1';

      return Marker(
        markerId: MarkerId(markerId),
        position: position,
        alpha: 1.0,
        anchor: const Offset(0.5, 1.0),
        consumeTapEvents: false,
        draggable: false,
        infoWindow: const InfoWindow(title: null, snippet: null),
        visible: true,
      );
    } catch (e) {
      return const Marker(
        markerId: MarkerId('1'),
        position: LatLng(0, 0),
      );
    }
  }

  @override
  goToNavigation() {
    Get.to(() => DeliveryNavigation(),
        arguments: {'orderid': orderid, 'undeliveredOrder': undeliveredOrders});
  }
}
