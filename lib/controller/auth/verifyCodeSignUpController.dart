import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/auth/verifycodedata.dart';
import 'package:sire/view/screens/home/home.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkCode(String verify);
  resendCode();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  String? email;
  StatusRequest statusRequest = StatusRequest.none;
  VerifycodeData verifycodeData = VerifycodeData(Get.find());

  @override
  checkCode(String verify) async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await verifycodeData.postData(email!, verify);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        // data.addAll(response['data']);
        Get.offAll(() => Home(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 800));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "warning!!",
            middleText:
                "please check that the confirmation code you entered is correct");
      }
    }
    update();
  }

  @override
  resendCode() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await verifycodeData.resendCode(email!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Verification code resent successfully.",
          "Please check your email for the new code",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.email_rounded),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "Failed to resend verification code.",
            middleText: "Something went wrong. Please try again later.");
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }
}
