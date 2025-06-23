import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/localization/changelocale.dart';
import 'package:sire/view/widgets/locale/Button.dart';

List<Widget> lcList() {
  return [
    LCButon(
      text: "idioma español",
      onPressed: () {
        Localecontroller().changelocale("es");
        Get.back();
      },
    ),
    LCButon(
      onPressed: () {
        Localecontroller().changelocale("ar");
        Get.back();
      },
      text: "اللفة العربية",
    ),
    LCButon(
      onPressed: () {
        Localecontroller().changelocale("en");
        Get.back();
      },
      text: "English language",
    ),
    Container(
      margin: const EdgeInsets.only(bottom: 18),
    ),
  ];
}
