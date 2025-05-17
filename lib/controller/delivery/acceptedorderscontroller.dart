import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/delivery/deliverydata.dart';
import 'package:sire/data/model/deliveryrequestmodel.dart';
import 'package:sire/view/screens/delivery/orderdetails.dart';

abstract class AcceptedOrdersController extends GetxController {
  getAcceptedOrders();
  String getPaymentType(int paymentCode);
  goToOrderDetails(String orderid, int index);
  markAsDelivered(String userid, String orderid);
}

class AcceptedOrdersControllerImp extends AcceptedOrdersController {
  late StatusRequest statusRequest;
  DeliveryData deliveryData = DeliveryData(Get.find());
  List<DeliveryRequestModel> acceptedOrders = [];
  bool loading = false;
  Services services = Get.find();

  @override
  getAcceptedOrders() async {
    statusRequest = StatusRequest.loding;
    acceptedOrders.clear();
    var response = await deliveryData
        .getAcceptedOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        acceptedOrders.addAll(
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
    getAcceptedOrders();
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
      'undeliveredOrder': acceptedOrders[index]
    });
  }

  @override
  markAsDelivered(userid, orderid) async {
    loading = true;
    var response = await deliveryData.markAsDelivered(orderid, userid);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      getAcceptedOrders();
      if (response["status"] == "success") {
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    loading = false;
    update();
  }
}
