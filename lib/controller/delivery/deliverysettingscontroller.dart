import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/disablenotification.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/delivery/deliverydata.dart';
import 'package:sire/view/screens/settings/updateaccountinformation.dart';
import 'package:sire/view/screens/auth/login.dart';
import 'package:sire/view/screens/delivery/viewdelivered.dart';

abstract class DeliverySettingsController extends GetxController {
  disableNotification();
  goToDeliveredOrders();
  goToUpdateAccountInformation();
  updateAccount();
  logout();
  getDeliveredCount();
}

class DeliverySettingsControllerImp extends DeliverySettingsController {
  Services services = Get.find();

  String? username;
  String? email;
  String? phoneNumber;
  String? pfp;
  String? banner;

  bool? isNotificationEnabled;

  DeliveryData deliveryData = DeliveryData(Get.find());
  int? deliveredCount;

  late StatusRequest statusRequest;

  @override
  void onInit() {
    getDeliveredCount();
    username = services.sharedPreferences.getString("username")!;
    email = services.sharedPreferences.getString("email")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    banner = services.sharedPreferences.getString("banner")!;
    phoneNumber = services.sharedPreferences.getString("phone")!;
    isNotificationEnabled =
        services.sharedPreferences.getBool("isNotificationEnabled");

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
  goToUpdateAccountInformation() {
    Get.to(
      () => const UpdateAccountInformation(),
      transition: Transition.leftToRight,
    );
  }

  @override
  goToDeliveredOrders() {
    Get.to(
      () => const ViewDelivered(),
      transition: Transition.leftToRight,
    );
  }

  @override
  updateAccount() {
    username = services.sharedPreferences.getString("username")!;
    email = services.sharedPreferences.getString("email")!;
    pfp = services.sharedPreferences.getString("pfp")!;
    banner = services.sharedPreferences.getString("banner")!;
    update();
  }

  @override
  logout() {
    FirebaseMessaging.instance.subscribeToTopic("notAuthorized");
    FirebaseMessaging.instance.unsubscribeFromTopic("delivery");
    FirebaseMessaging.instance.unsubscribeFromTopic(
        "user_${services.sharedPreferences.getString("id")!}");
    services.sharedPreferences.clear();
    services.sharedPreferences.setString("step", "1");
    Get.offAll(
      () => const Login(),
      transition: Transition.size,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  getDeliveredCount() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await deliveryData
        .getCountDelivered(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        deliveredCount = data[0]["count_total"];
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
