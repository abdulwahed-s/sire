import 'dart:io';

import 'package:get/get.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: "warning",
    middleText: "do you really want to exit",
    onCancel: () {
      Get.back();
    },
    onConfirm: () {
      exit(0);
    },
  );
  return Future.value(true);
}
