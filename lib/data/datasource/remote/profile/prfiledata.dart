import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class ProfileData {
  Curd curd;
  ProfileData(this.curd);

  getCountOrders(String userid) async {
    var resp = await curd.postData(AppLink.getTotalOrders, {"id": userid});
    return resp.fold((s) => s, (r) => r);
  }
}
