import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class VerifyCodePassData{
  Curd curd;
  VerifyCodePassData(this.curd);
  postData(String email, String veridycode) async {
    var resp = await curd.postData(AppLink.verifycodepass, {
      "email": email,
      "veridycode": veridycode,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
