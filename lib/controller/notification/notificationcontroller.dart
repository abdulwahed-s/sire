import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/notification/notificationdata.dart';
import 'package:sire/data/model/notificationmodel.dart';

abstract class NotificationController extends GetxController {
  getNotification();
  deleteNotification(String notificationID, int index);
}

class NotificationControllerImp extends NotificationController {
  Services services = Get.find();
  late StatusRequest statusRequest;
  NotificationData notificationData = NotificationData(Get.find());

  List<NotificationModel> allNotification = [];

  @override
  getNotification() async {
    statusRequest = StatusRequest.loding;
    update();
    allNotification.clear();
    var response = await notificationData
        .getNotification(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        allNotification.addAll(
          data.map(
            (e) => NotificationModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  deleteNotification(notificationID, index) {
    notificationData.deleteNotification(
      services.sharedPreferences.getString("id")!,
      notificationID,
    );
    allNotification.removeAt(index);
    update();
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
