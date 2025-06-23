import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/notification/notificationdata.dart';
import 'package:sire/view/screens/home/home.dart';
import 'package:sire/view/screens/items/viewFavourite.dart';
import 'package:sire/view/screens/profile/profile.dart';
import 'package:sire/view/screens/settings/settings.dart';

abstract class HomeScreenController extends GetxController {
  void changePage(int i);
  getNotificationsCount();
}

class HomeScreenControllerImp extends HomeScreenController {
  late StatusRequest statusRequestNotification;
  NotificationData notificationData = NotificationData(Get.find());
  List data = [];
  Services services = Get.find();

  int currentpage = 0;

  List<Widget> listpages = [
    const Home(),
    const ViewFavourite(),
    const Profile(),
    const Settings(),
  ];
  List<String> namepages = [
    "Home",
    "Favorite",
    "Profile",
    "Setting",
  ];
  List<IconData> iconpages = [
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
    Icons.settings_outlined,
  ];

  @override
  changePage(i) {
    currentpage = i;
    update();
  }

  @override
  void onInit() {
    currentpage = Get.arguments?['num'] ?? 0;
    getNotificationsCount();

    super.onInit();
  }

  @override
  getNotificationsCount() async {
    statusRequestNotification = StatusRequest.loding;
    data.clear();
    var response = await notificationData
        .getNotificationCount(services.sharedPreferences.getString("id")!);
    statusRequestNotification = handlingdata(response);
    if (statusRequestNotification == StatusRequest.success) {
      if (response["status"] == "success") {
        data.addAll(response['data']);
      } else if (response["status"] == "failure") {
        statusRequestNotification = StatusRequest.failure;
      }
    }
    Get.find<HomeControllerImp>().update();
    update();
  }

  int getUnreadCount() {
    try {
      if (data.isNotEmpty && data[0]["unread_count"] != null) {
        return data[0]["unread_count"] as int;
      }
    } catch (e) {
      debugPrint('Error getting unread count: $e');
    }
    return 0;
  }
}
