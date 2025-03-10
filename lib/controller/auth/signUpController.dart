import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/auth/signupdata.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/auth/verifycodesignup.dart';

abstract class SignupController extends GetxController {
  signUp();
  showPassword();
  goToVerfiy();
  goToLogin();
}

class SignUpcontrollerImp extends SignupController {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController password;
  StatusRequest statusRequest = StatusRequest.none;
  SignUpData signUpData = SignUpData(Get.find());
  Services service = Get.find();
  List data = [];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  showPassword() {
    obscureText = !obscureText;
    update();
  }

  @override
  signUp() async {
    var fomrstate = formkey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await signUpData.postData(
          username.text, email.text, phoneNumber.text, password.text);
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          // data.addAll(response['data']);
        service.sharedPreferences.setString("id", response["data"]["user_id"].toString());
        service.sharedPreferences.setString("username", response["data"]["user_name"]);
        service.sharedPreferences.setString("email", response["data"]["user_email"]);
        service.sharedPreferences.setString("phone", response["data"]["user_phone"]);
        service.sharedPreferences.setString("step", "2");
          goToVerfiy();
        } else {
          statusRequest = StatusRequest.failure;
          Get.defaultDialog(
              title: "warning!!",
              middleText: response["status"] == "emailfail"
                  ? "the email you entered is already in use please try logging in"
                  : response["status"] == "userfail"
                      ? "this username is already taken"
                      : "the phone number you ve entered already exists with another account");
        }
      }
      update();
    } else {}
  }

  @override
  goToLogin() {
    Get.offAll(() =>Login(),
        transition: Transition.leftToRight,
        duration: Duration(milliseconds: 800));
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToVerfiy() {
    Get.off(() =>VerifyCodeSignUp(),
        arguments: {"email": email.text},
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }
}
