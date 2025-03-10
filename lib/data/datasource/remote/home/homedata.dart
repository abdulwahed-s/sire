import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class HomeData {
  Curd curd;
  HomeData(this.curd);
  postData() async {
    var resp = await curd.postData(AppLink.home, {});
    return resp.fold((s) => s, (r) => r);
  }
}
