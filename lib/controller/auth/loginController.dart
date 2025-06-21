import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/localization/changelocale.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/auth/logindata.dart';
import 'package:sire/view/screens/admin/adminhome.dart';
import 'package:sire/view/screens/auth/signUp.dart';
import 'package:sire/view/screens/delivery/deliveryhome.dart';
import 'package:sire/view/screens/home/homescreen.dart';
import 'package:sire/view/screens/resetpassword/forgotpassword.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  showPassword();
  goToForgotPassword();
  saveCachedData(var response);
  userHome();
  deliveryHome();
  adminHome();
  changeLoginRemember(bool value);
}

class LogincontrollerImp extends LoginController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool obscureText = true;
  List data = [];
  Services service = Get.find();
  late TextEditingController username;
  late TextEditingController password;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  bool rememberMe = true;

  @override
  login() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await loginData.postData(username.text, password.text);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        saveCachedData(response);
        FirebaseMessaging.instance.unsubscribeFromTopic("notAuthorized");
        FirebaseMessaging.instance
            .subscribeToTopic("user_${response["data"]["user_id"]}");
        if (response["data"]["user_keyaccess"] == 0) {
          userHome();
        } else if (response["data"]["user_keyaccess"] == 1) {
          deliveryHome();
        } else if (response["data"]["user_keyaccess"] == 2) {
          adminHome();
        }
        Get.find<Localecontroller>().geIsVerified();
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

  @override
  saveCachedData(response) {
    service.sharedPreferences
        .setString("id", response["data"]["user_id"].toString());
    service.sharedPreferences
        .setString("username", response["data"]["user_name"]);
    service.sharedPreferences
        .setString("email", response["data"]["user_email"]);
    service.sharedPreferences
        .setString("phone", response["data"]["user_phone"]);
    service.sharedPreferences.setString("pfp", response["data"]["user_pfp"]);
    service.sharedPreferences
        .setString("banner", response["data"]["user_banner"]);
    service.sharedPreferences
        .setString("key", response["data"]["user_keyaccess"].toString());
    service.sharedPreferences
        .setString("approve", response["data"]["user_approve"].toString());
    service.sharedPreferences.setBool("isNotificationEnabled", true);
  }

  @override
  adminHome() {
    if (rememberMe) {
      service.sharedPreferences.setString("step", "4");
    }
    FirebaseMessaging.instance.subscribeToTopic("admin");
    Get.off(() => AdminHome(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }

  @override
  deliveryHome() {
    if (rememberMe) {
      service.sharedPreferences.setString("step", "3");
    }
    FirebaseMessaging.instance.subscribeToTopic("delivery");
    Get.off(() => DeliveryHome(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }

  @override
  userHome() {
    if (rememberMe) {
      service.sharedPreferences.setString("step", "2");
    }
    FirebaseMessaging.instance.subscribeToTopic("users");
    Get.off(() => HomeScreen(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 800));
  }

  @override
  changeLoginRemember(bool value) {
    rememberMe = value;
    update();
  }
}
