import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/orders/orderdata.dart';
import 'package:sire/data/model/ordersmodel.dart';
import 'package:sire/view/screens/orders/orderdetails.dart';

abstract class ArchivedOrdersController extends GetxController {
  getArchivedOrders();
  String getPaymentType(int paymentCode);
  String getOrderType(int typeCode);
    getOrderDetails(String orderid);
}

class ArchivedOrdersControllerImp extends ArchivedOrdersController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  OrderData orderData = OrderData(Get.find());

  List<OrdersModel> archivedOrders = [];

  @override
  getArchivedOrders() async {
    statusRequest = StatusRequest.loding;
    archivedOrders.clear();
    var response = await orderData
        .getArchivedOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        archivedOrders.addAll(
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
    getArchivedOrders();
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
  getOrderDetails(orderid) {
    Get.to(
      () => const OrderDetails(),
      arguments: {"orderid": orderid},
    );
  }
}
