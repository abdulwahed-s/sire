import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/functions/notificationconfiguration.dart';
import 'package:sire/core/services/services.dart';

class Localecontroller extends GetxController {
  late Locale languge;
  Services service = Get.find();
  changelocale(String langcode) {
    Locale locale = Locale(langcode);
    service.sharedPreferences.setString("langcode", langcode);
    Get.updateLocale(locale);
  }

  bool? isNotVerfied;

  bool geIsVerified() {
    isNotVerfied = service.sharedPreferences.getString("approve") == "0";
    update();
    return isNotVerfied!;
  }

  @override
  void onInit() {
    notificationConfiguration();
    notificationListen();
    FirebaseMessaging.instance.subscribeToTopic("notAuthorized");
    String? locale = service.sharedPreferences.getString('langcode');
    if (locale == "en") {
      languge = const Locale("en");
    } else if (locale == "ar") {
      languge = const Locale("ar");
    } else if (locale == "es") {
      languge = const Locale("es");
    } else {
      languge = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
