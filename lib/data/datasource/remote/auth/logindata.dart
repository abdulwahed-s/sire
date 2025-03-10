import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class LoginData{
  Curd curd;
  LoginData(this.curd);
  postData(String username, String password) async {
    var resp = await curd.postData(AppLink.login, {
      "username": username,
      "password": password,
    });
    return resp.fold((s) => s, (r) => r);
  }
}
