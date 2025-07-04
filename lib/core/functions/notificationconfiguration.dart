import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:get/get.dart';
import 'package:app_settings/app_settings.dart';
import 'package:lottie/lottie.dart';
import 'package:sire/controller/admin/adminhomecontroller.dart';
import 'package:sire/controller/delivery/deliveryhomecontroller.dart';
import 'package:sire/controller/delivery/deliveryrequestscontroller.dart';
import 'package:sire/controller/home/homescreenController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/services/services.dart';

Future<void> notificationConfiguration() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings initialSettings =
      await messaging.getNotificationSettings();
  if (initialSettings.authorizationStatus == AuthorizationStatus.authorized) {
    return;
  }

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    Get.snackbar(
      "Success",
      "Notification permission granted",
      colorText: Appcolor.charcoalGray,
      backgroundColor: Appcolor.rosePompadour,
      icon: const Icon(Icons.notifications_active),
    );
  } else if (settings.authorizationStatus == AuthorizationStatus.denied ||
      settings.authorizationStatus == AuthorizationStatus.provisional) {
    Get.defaultDialog(
      title: "Notifications Disabled",
      middleText:
          "Please enable notifications in settings to receive important updates",
      textConfirm: "Open Settings",
      textCancel: "Cancel",
      onConfirm: () {
        Get.back();
        AppSettings.openAppSettings();
      },
      onCancel: () => Get.back(),
    );
  }
}

notificationListen() {
  FirebaseMessaging.onMessage.listen(
    (event) {
      Services services = Get.find();
      String key = services.sharedPreferences.getString("key")!;
      if (key == "0") {
        Get.find<HomeScreenControllerImp>().getNotificationsCount();
      } else if (key == "1") {
        Get.find<DeliveryHomeControllerImp>().getNotificationsCount();
        Get.find<DeliveryRequestsControllerImp>().getUndeliveredOrders();

      } else if (key == "2") {
        Get.find<AdminHomeControllerImp>().getNotificationsCount();
      }
      final imageUrl = event.notification?.android?.imageUrl ??
          event.notification?.apple?.imageUrl;
      FlutterRingtonePlayer().play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.glass,
      );
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 150,
                  child: imageUrl == null
                      ? Lottie.asset("lottie/notification.json",
                          fit: BoxFit.contain, frameRate: const FrameRate(60))
                      : Image.network(imageUrl),
                ),
                const SizedBox(height: 20),
                Text(
                  event.notification!.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sw",
                    color: Appcolor.amaranthpink,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  event.notification!.body!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.amaranthpink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    Get.back();
                    FlutterRingtonePlayer().stop();
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    },
  );
}
