import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class OrderData {
  Curd curd;
  OrderData(this.curd);
  getPendingOrders(String userid) async {
    var resp = await curd.postData(AppLink.viewPendingOrders, {
      "userID": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }

    getArchivedOrders(String userid) async {
    var resp = await curd.postData(AppLink.viewArchivedOrders, {
      "userID": userid,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
