import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/admin/offermessage/offercontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/addimage.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';

import '../../../core/constant/color.dart';

abstract class EditOfferController extends GetxController {
  editOfferMessage();
}

class EditOfferControllerImp extends EditOfferController {
  StatusRequest statusRequest = StatusRequest.none;
  AdminData adminData = AdminData(Get.find());

  TextEditingController? title;
  TextEditingController? body;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  File? file;

  List data = [];
  String? oldimg;

  getImageByGallery() async {
    file = await uploadImage();
    update();
  }

  getImageByCamera() async {
    file = await pickImageFromCamera();
    update();
  }

  @override
  editOfferMessage() async {
    statusRequest = StatusRequest.loding;
    var response = await adminData.editOfferMessage(
      title!.text,
      body!.text,
      oldimg!,
      file,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.find<OfferControllerImp>().getOfferMessage();
        Get.back();
        Get.snackbar(
          "Success",
          "Offer Message Edited successfully",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    title = TextEditingController();
    body = TextEditingController();

    data = Get.arguments["data"];
    title!.text = data[0]["mainpage_title"];
    body!.text = data[0]["mainpage_body"];
    oldimg = data[0]["mainpage_image"];

    super.onInit();
  }

    ImageProvider getPreviewImage() {
    if (file != null) {
      return FileImage(file!);
    } else {
      return CachedNetworkImageProvider(
        AppLink.homeimage + data[0]["mainpage_image"],
      );
    }
  }
}
