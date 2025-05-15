import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/delivery/deliverydata.dart';
import 'package:sire/data/model/deliveryrequestmodel.dart';
import 'package:sire/view/screens/delivery/orderdetails.dart';

abstract class DeliveryRequestsController extends GetxController {
  getUndeliveredOrders();
  String getPaymentType(int paymentCode);
  goToOrderDetails(String orderid, int index);
  acceptorder(String userid, String orderid);
}

class DeliveryRequestsControllerImp extends DeliveryRequestsController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<DeliveryRequestModel> undeliveredOrders = [];
  bool loading = false;
  Services services = Get.find();

  @override
  getUndeliveredOrders() async {
    statusRequest = StatusRequest.loding;
    undeliveredOrders.clear();
    var response = await deliveryData.getUndeliveredOrders();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        undeliveredOrders.addAll(
          data.map(
            (e) => DeliveryRequestModel.fromJson(e),
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
    getUndeliveredOrders();
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
  goToOrderDetails(orderid, index) {
    Get.to(() => DeliveryOrderDetails(), arguments: {
      'orderid': orderid,
      'undeliveredOrder': undeliveredOrders[index]
    });
  }

  @override
  acceptorder(userid, orderid) async {
    loading = true;
    var response = await deliveryData.acceptOrder(
        userid, orderid, services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      getUndeliveredOrders();
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }
}
