import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/settings/adminsettingscontroller.dart';
import 'package:sire/controller/delivery/deliverysettingscontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/addimage.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/settings/settingsdata.dart';

abstract class UpdateAccountInformationController extends GetxController {
  updateAccountInformation();
}

class UpdateAccountInformationControllerImp
    extends UpdateAccountInformationController {
  GlobalKey<FormState> globalKey = GlobalKey();
  StatusRequest statusRequest = StatusRequest.none;
  SettingsData settingsData = SettingsData(Get.find());

  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? phoneNumber;
  TextEditingController? password;
  String? oldpfp;
  String? oldbanner;
  String? key;

  Services services = Get.find();

  File? pfp;
  File? banner;

  Future<File?> getImageByGallery(File? file, bool pfp) async {
    file = await uploadImage();
    if (file != null) {
      file = pfp
          ? await cropImageWithRatio(file, 1, 1, "Crop Profile Picture")
          : await cropImageWithRatio(file, 3, 1, "Crop Banner");
    }
    update();
    return file;
  }

  Future<File?> getImageByCamera(File? file, bool pfp) async {
    file = await pickImageFromCamera();
    if (file != null) {
      file = pfp
          ? await cropImageWithRatio(file, 1, 1, "Crop Profile Picture")
          : await cropImageWithRatio(file, 3, 1, "Crop Banner");
    }
    update();
    return file;
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    oldpfp = services.sharedPreferences.getString("pfp");
    oldbanner = services.sharedPreferences.getString("banner");
    key = services.sharedPreferences.getString("key")!;

    username!.text = services.sharedPreferences.getString("username")!;
    email!.text = services.sharedPreferences.getString("email")!;
    phoneNumber!.text = services.sharedPreferences.getString("phone")!;

    super.onInit();
  }

  @override
  updateAccountInformation() async {
    var fomrstate = globalKey.currentState;
    if (fomrstate!.validate()) {
      statusRequest = StatusRequest.loding;
      update();
      var response = await settingsData.updateAccountInformation(
        services.sharedPreferences.getString("id")!,
        username!.text,
        email!.text,
        phoneNumber!.text,
        password!.text,
        oldpfp!,
        oldbanner!,
        pfp,
        banner,
      );
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          services.sharedPreferences
              .setString("username", response["data"]["user_name"]);
          services.sharedPreferences
              .setString("email", response["data"]["user_email"]);
          services.sharedPreferences
              .setString("phone", response["data"]["user_phone"]);
          if (response["data"]["user_pfp"] != null) {
            services.sharedPreferences
                .setString("pfp", response["data"]["user_pfp"]);
          }
          if (response["data"]["user_banner"] != null) {
            services.sharedPreferences
                .setString("banner", response["data"]["user_banner"]);
          }
          switch (key) {
            case ("1"):
              Get.find<DeliverySettingsControllerImp>().updateAccount();
            case ("2"):
              Get.find<AdminSettingsControllerImp>().updateAccount();
          }
          Get.back();
          Get.snackbar(
            "Success",
            "Your account information has been successfully updated",
            colorText: Appcolor.charcoalGray,
            backgroundColor: Appcolor.rosePompadour,
            icon: const Icon(Icons.check_circle),
          );
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
    }
  }
}
