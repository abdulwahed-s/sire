import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class CheckEmailData{
  Curd curd;
  CheckEmailData(this.curd);
  postData(String email) async {
    var resp = await curd.postData(AppLink.checkemail, {
      "email": email,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
