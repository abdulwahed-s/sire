import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class TestData {
  Curd curd = Curd();
  TestData(this.curd);
  getData() async {
    var resp = await curd.postData(AppLink.test, {});
  return  resp.fold((s) => s, (r) => r);
  }
}
