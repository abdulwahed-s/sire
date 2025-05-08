import 'dart:io';

import 'package:get/get.dart';
import 'package:sire/core/constant/color.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: "warning",
    middleText: "do you really want to exit",
    backgroundColor: Appcolor.white,
    buttonColor: Appcolor.berry,
    cancelTextColor: Appcolor.black,
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      exit(0);
    },
  );
  return Future.value(true);
}
