import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SettingController extends GetxController {
  logout();
  contactus(int type);
  goToAddress();
}

class SettingControllerImp extends SettingController {
  Services services = Get.find<Services>();

  @override
  goToAddress() {
    Get.to(() => ViewAddress(),
        transition: Transition.native, duration: Duration(seconds: 1));
  }

  @override
  logout() {
    FirebaseMessaging.instance.subscribeToTopic("notAuthorized");
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance
        .unsubscribeFromTopic(services.sharedPreferences.getString("id")!);
    services.sharedPreferences.clear();
    services.sharedPreferences.setString("step", "1");
    Get.offAll(
      () => Login(),
      transition: Transition.size,
      duration: Duration(seconds: 1),
    );
  }

  @override
  contactus(type) async {
    if (type == 0) {
      final encodedMessage =
          Uri.encodeComponent("Hello I wanted to talk with you about\n");
      final url = 'https://wa.me/+96879850218?text=$encodedMessage';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          "Error",
          "Could not launch WhatsApp",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.error_outline_rounded),
        );
      }
    } else if (type == 1) {
      final encodedMessage =
          Uri.encodeComponent("Hello I wanted to talk with you about\n");
      final uri = Uri.parse('sms:+96879850218?body=$encodedMessage');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        Get.snackbar(
          "Error",
          "Could not launch SMS app",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.error_outline_rounded),
        );
      }
    }
  }
}
