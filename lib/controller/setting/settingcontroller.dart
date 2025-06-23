import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/disablenotification.dart';
import 'package:sire/core/localization/changelocale.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/auth/verifycodesignup.dart';
import 'package:sire/view/screens/settings/updateaccountinformation.dart';
import 'package:sire/view/screens/settings/viewallrating.dart';
import 'package:sire/view/widgets/settings/language.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SettingController extends GetxController {
  logout();
  contactus(int type);
  goToAddress();
  disableNotification();
  changeLanguages();
  goToUpdateAccountInformation();
  goToAllRating();
  goToVerify();
}

class SettingControllerImp extends SettingController {
  Services services = Get.find<Services>();

  String? username;
  String? email;
  String? pfp;
  bool? isApprove;

  bool? isNotificationEnabled;

  @override
  goToAddress() {
    Get.to(() => const ViewAddress(),
        transition: Transition.native, duration: const Duration(seconds: 1));
  }

  @override
  logout() {
    FirebaseMessaging.instance.subscribeToTopic("notAuthorized");
    FirebaseMessaging.instance.unsubscribeFromTopic("users");
    FirebaseMessaging.instance.unsubscribeFromTopic(
        "user_${services.sharedPreferences.getString("id")!}");
    services.sharedPreferences.clear();
    services.sharedPreferences.setString("step", "1");
    Get.find<Localecontroller>().geIsVerified();
    Get.offAll(
      () => const Login(),
      transition: Transition.size,
      duration: const Duration(seconds: 1),
    );
    update();
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

  @override
  void onInit() {
    isNotificationEnabled =
        services.sharedPreferences.getBool("isNotificationEnabled");
    username = services.sharedPreferences.getString("username");
    email = services.sharedPreferences.getString("email");
    pfp = services.sharedPreferences.getString("pfp");
    isApprove = services.sharedPreferences.getString("approve") == "1";

    super.onInit();
  }

  @override
  disableNotification() {
    disableNotifications();
    isNotificationEnabled =
        services.sharedPreferences.getBool("isNotificationEnabled");
    update();
  }

  @override
  changeLanguages() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Appcolor.rosePompadour,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "2".tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Language options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: buildLanguageOptions(),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  List<Widget> buildLanguageOptions() {
    final languages = [
      LanguageOption(
        code: "en",
        name: "English",
        nativeName: "English",
        flag: "🇺🇸",
      ),
      LanguageOption(
        code: "es",
        name: "Spanish",
        nativeName: "Español",
        flag: "🇪🇸",
      ),
      LanguageOption(
        code: "ar",
        name: "Arabic",
        nativeName: "العربية",
        flag: "🇸🇦",
      ),
    ];

    return languages
        .map(
          (lang) => LanguageButton(
            language: lang,
            onPressed: () {
              Localecontroller().changelocale(lang.code);
              Get.back();
            },
          ),
        )
        .toList();
  }

  @override
  goToUpdateAccountInformation() {
    Get.to(
      () => const UpdateAccountInformation(),
      transition: Transition.leftToRight,
    );
  }

  @override
  goToAllRating() {
    Get.to(
      () => const ViewAllRating(),
      transition: Transition.leftToRight,
    );
  }

  @override
  goToVerify() {
    Get.to(
      () => const VerifyCodeSignUp(),
      arguments: {
        "email": email,
        "setting": true,
      },
      transition: Transition.leftToRight,
    );
  }
}
