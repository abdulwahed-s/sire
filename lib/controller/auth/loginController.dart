import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/auth/logindata.dart';
import 'package:sire/view/screens/auth/signUp.dart';
import 'package:sire/view/screens/home/homescreen.dart';
import 'package:sire/view/screens/resetpassword/forgotpassword.dart';

abstract class loginController extends GetxController {
  login();
  goToSignUp();
  showPassword();
  goToForgotPassword();
}

class LogincontrollerImp extends loginController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;
  List data = [];
  Services service = Get.find();
  late TextEditingController username;
  late TextEditingController password;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  login() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await loginData.postData(username.text, password.text);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        service.sharedPreferences
            .setString("id", response["data"]["user_id"].toString());
        service.sharedPreferences
            .setString("username", response["data"]["user_name"]);
        service.sharedPreferences
            .setString("email", response["data"]["user_email"]);
        service.sharedPreferences
            .setString("phone", response["data"]["user_phone"]);
        service.sharedPreferences.setString("step", "2");
    FirebaseMessaging.instance.unsubscribeFromTopic("notAuthorized");
    FirebaseMessaging.instance.subscribeToTopic("users");
    FirebaseMessaging.instance.subscribeToTopic(response["data"]["user_id"].toString());
        Get.off(() => HomeScreen(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 800));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "warning!!",
            middleText: "username or password you entered is incorrect");
      }
    }
    update();
  }

  @override
  goToSignUp() {
    Get.off(() => SignUp(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }

  @override
  goToForgotPassword() {
    Get.to(() => ForgotPassword(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }

  @override
  void onInit() {
    username = TextEditingController();
    password = TextEditingController();
    FirebaseMessaging.instance.getToken().then((value) {
      print(value);
    });
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  showPassword() {
    obscureText = !obscureText;
    update();
  }
}
