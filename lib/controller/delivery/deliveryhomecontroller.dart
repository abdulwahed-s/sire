import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/delivery/acceptedorderscontroller.dart';
import 'package:sire/controller/delivery/deliveryrequestscontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/notification/notificationdata.dart';
import 'package:sire/view/screens/delivery/acceptedorders.dart';
import 'package:sire/view/screens/delivery/deliveryrequests.dart';
import 'package:sire/view/screens/delivery/deliverysettings.dart';
import 'package:sire/view/screens/notification/viewnotification.dart';

abstract class DeliveryHomeController extends GetxController {
  void changePage(int i);
  getNotificationsCount();
  Color getIconColor(
      bool isActive, bool isNotificationTab, int unreadCount, ThemeData theme);
  int getUnreadCount();
}

class DeliveryHomeControllerImp extends DeliveryHomeController {
  late StatusRequest statusRequestNotification;
  NotificationData notificationData = NotificationData(Get.find());
  List data = [];
  Services services = Get.find();

  int currentpage = 0;
  List<Widget> listpages = [
    const DeliveryRequests(),
    const AcceptedOrders(),
    const ViewNotification(),
    const DeliverySettings()
  ];
  List<String> namepages = [
    "Pending",
    "Accepted",
    "Notification",
    "Settings",
  ];
  List<IconData> iconpages = [
    Icons.local_shipping,
    Icons.assignment_turned_in,
    Icons.notifications_active,
    Icons.settings,
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
    Get.put(AcceptedOrdersControllerImp());
    Get.put(DeliveryRequestsControllerImp());

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
    update();
  }

  @override
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

  @override
  Color getIconColor(
    bool isActive,
    bool isNotificationTab,
    int unreadCount,
    ThemeData theme,
  ) {
    if (isNotificationTab && unreadCount > 0) {
      return Colors.amber.shade600;
    }
    if (isActive) {
      return Appcolor.berry;
    }
    return theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ??
        Colors.grey[600]!;
  }
}
