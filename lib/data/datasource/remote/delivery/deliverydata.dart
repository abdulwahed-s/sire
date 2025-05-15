import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class DeliveryData {
  Curd curd;
  DeliveryData(this.curd);
  getUndeliveredOrders() async {
    var resp = await curd.postData(AppLink.undeliveredOrders, {});
    return resp.fold((s) => s, (r) => r);
  }

  getOrderDetails(String orderid) async {
    var resp = await curd.postData(AppLink.deliveryOrderDetails, {
      "orderid": orderid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  acceptOrder(String userid, String orderid, String workerid) async {
    var resp = await curd.postData(AppLink.acceptorder, {
      "userid": userid,
      "workerid": workerid,
      "orderid": orderid,
    });
    return resp.fold((s) => s, (r) => r);
  }

  getAcceptedOrders(String workerid) async {
    var resp =
        await curd.postData(AppLink.viewAcceptedOrders, {"workerid": workerid});
    return resp.fold((s) => s, (r) => r);
  }

  markAsDelivered(String orderid, String userid) async {
    var resp = await curd.postData(
        AppLink.markAsDelivered, {"orderid": orderid, "userid": userid});
    return resp.fold((s) => s, (r) => r);
  }
}
