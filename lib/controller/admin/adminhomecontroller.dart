import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/notification/notificationdata.dart';
import 'package:sire/view/screens/admin/categories/categories.dart';
import 'package:sire/view/screens/admin/coupon/admincoupon.dart';
import 'package:sire/view/screens/admin/dashboardhome.dart';
import 'package:sire/view/screens/admin/items/itemsview.dart';
import 'package:sire/view/screens/admin/offermessage/offer.dart';
import 'package:sire/view/screens/admin/orders/vieworders.dart';
import 'package:sire/view/screens/admin/settings/adminsetting.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/notification/viewnotification.dart';

abstract class AdminHomeController extends GetxController {
  void changePage(int i);
  logout();
  getNotificationsCount();
}

class AdminHomeControllerImp extends AdminHomeController {
  late StatusRequest statusRequest;
  NotificationData notificationData = NotificationData(Get.find());
  List data = [];

  Services services = Get.find();
  String? username;
  String? email;
  String? pfp;
  String? banner;

  int currentpage = 0;
  List<Widget> listpages = [
    DashboardHome(),
    AdminItemsView(),
    Categories(),
    ViewOrders(),
    AdminCoupon(),
    Offer(),
    ViewNotification(visableAppBar: false),
    AdminSetting(),
  ];

  List<String> namepages = [
    "Dashboard",
    "Products",
    "Categories",
    "Orders",
    "Coupons",
    "Offer",
    "Notification",
    "Setting",
  ];
  List<IconData> iconpages = [
    Iconsax.home,
    Iconsax.shop,
    Iconsax.category,
    Iconsax.shopping_cart,
    Iconsax.gift,
    Iconsax.shop,
    Iconsax.notification,
    Iconsax.setting,
  ];

  @override
  changePage(i) {
    currentpage = i;
    update();
  }

  @override
  void onInit() {
    username = services.sharedPreferences.getString("username")!;
    email = services.sharedPreferences.getString("email")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    banner = services.sharedPreferences.getString("banner")!;
    currentpage = Get.arguments?['num'] ?? 0;

    getNotificationsCount();
    super.onInit();
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
  getNotificationsCount() async {
    statusRequest = StatusRequest.loding;
    data.clear();
    var response = await notificationData
        .getNotificationCount(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        data.addAll(response['data']);
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
