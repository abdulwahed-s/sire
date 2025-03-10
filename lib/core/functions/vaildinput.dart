import 'package:get/get.dart';

vaildInput(String val, String type) {
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "Not Vaild UserName";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Not Vaild Email";
    }
  }
  if (type == "password") {
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(val)) {
      return "Not Vaild Password";
    }
  }
  if (type == "PhoneNumber") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "Not Vaild Phone Number";
    }
  }
}
