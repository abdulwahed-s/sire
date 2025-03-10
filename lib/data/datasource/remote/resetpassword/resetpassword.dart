import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class ResetPasswordData{
  Curd curd;
  ResetPasswordData(this.curd);
  postData(String email, String password,String code) async {
    var resp = await curd.postData(AppLink.resetpassword, {
      "email": email,
      "password": password,
      "veridycode":code
    });
    return resp.fold((s) => s, (r) => r);
  }
}
