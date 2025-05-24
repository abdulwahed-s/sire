import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';
import 'package:sire/data/model/admindetails.dart';
import 'package:sire/data/model/itemdeliverymodel.dart';

abstract class AdminOrderDetailsController extends GetxController {
  getOrderDetails();
  String getPaymentType(int paymentCode);
  String getOrderType(int typeCode);
  getStatusText(double statusCode, int orderType);
}

class AdminOrderDetailsControllerImp extends AdminOrderDetailsController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<ItemDeliveryModel> orderDetails = [];
  AdminDetails adminDetailsModel = AdminDetails();
  String? orderid;
  Marker? marker;
  CameraPosition? cameraPosition;

  @override
  getOrderDetails() async {
    statusRequest = StatusRequest.loding;
    orderDetails.clear();
    var response = await adminData.getOrderDetails(orderid!);
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
    adminDetailsModel = Get.arguments['orderDetail'];
    getOrderDetails();
    marker = Marker(
      markerId: const MarkerId('marker'),
      position: LatLng(
        adminDetailsModel.addressLat ?? 0,
        adminDetailsModel.addressLong ?? 0,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    );
    cameraPosition = CameraPosition(
      target: LatLng(
        adminDetailsModel.addressLat ?? 0,
        adminDetailsModel.addressLong ?? 0,
      ),
      zoom: 14.4746,
    );
    super.onInit();
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
  String getStatusText(double statusCode, int orderType) {
    switch (statusCode) {
      case 0:
        return 'Pending Approval';
      case 1:
        return 'Preparing';
      case 1.5:
        return 'Waiting for delivery';
      case -1:
        return 'Cancelled';
      case 5:
        return 'Picked Up';
      case 6:
        return 'Archived';
    }

    if (orderType == 0) {
      switch (statusCode) {
        case 2:
          return 'On The Way';
        case 3:
          return 'Delivered';
      }
    } else {
      if (statusCode == 4) return 'Ready for Pickup';
    }

    return 'Unknown Status';
  }
}
