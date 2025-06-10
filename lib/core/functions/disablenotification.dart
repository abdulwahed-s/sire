import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sire/core/services/services.dart';

Services services = Get.find();

disableNotifications() {
  bool isNotificationEnabled =
      services.sharedPreferences.getBool("isNotificationEnabled")!;
  String key = services.sharedPreferences.getString("key")!;
  String id = services.sharedPreferences.getString("id")!;
  if (isNotificationEnabled) {
    switch (key) {
      case "0":
        FirebaseMessaging.instance.unsubscribeFromTopic("users");
        FirebaseMessaging.instance.unsubscribeFromTopic("user_$id");
      case "1":
        FirebaseMessaging.instance.unsubscribeFromTopic("delivery");
        FirebaseMessaging.instance.unsubscribeFromTopic("user_$id");
      case "2":
        FirebaseMessaging.instance.unsubscribeFromTopic("admin");
        FirebaseMessaging.instance.unsubscribeFromTopic("user_$id");
    }
  } else {
    switch (key) {
      case "0":
        FirebaseMessaging.instance.subscribeToTopic("users");
        FirebaseMessaging.instance.subscribeToTopic("user_$id");
      case "1":
        FirebaseMessaging.instance.subscribeToTopic("delivery");
        FirebaseMessaging.instance.subscribeToTopic("user_$id");
      case "2":
        FirebaseMessaging.instance.subscribeToTopic("admin");
        FirebaseMessaging.instance.subscribeToTopic("user_$id");
    }
  }
  services.sharedPreferences
      .setBool("isNotificationEnabled", !isNotificationEnabled);
}
