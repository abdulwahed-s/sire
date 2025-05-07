import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/orders/orderdata.dart';
import 'package:sire/data/model/orderdetailsmodel.dart';

abstract class OrderDetailsController extends GetxController {
  getOrderDetails();
}

class OrderDetailsControllerImp extends OrderDetailsController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  OrderData orderData = OrderData(Get.find());

  List<OrderDetailsModel> orderDetails = [];

  String? orderid;

  Set<Marker>? markers;

  @override
  getOrderDetails() async {
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await orderData.getOrderDetails(
        services.sharedPreferences.getString("id")!, orderid!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        orderDetails.addAll(
          data.map(
            (e) => OrderDetailsModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
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
  void onInit() {
    orderid = Get.arguments["orderid"];

    getOrderDetails();
    super.onInit();
  }
}
