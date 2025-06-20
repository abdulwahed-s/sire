import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/profile/prfiledata.dart';
import 'package:sire/view/screens/orders/archivedorders.dart';
import 'package:sire/view/screens/orders/pendingorders.dart';

abstract class ProfileController extends GetxController {
  getTotalOrdersCount();
  goToUnDeliverdOrders();
  goToArchivedOrder();
}

class ProfileControllerImp extends ProfileController {
  String? username;
  String? email;
  String? number;
  String? pfp;
  String? banner;
  bool? approve;

  Services services = Get.find();

  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List data = [];

  @override
  void onInit() {
    username = services.sharedPreferences.getString("username");
    email = services.sharedPreferences.getString("email");
    number = services.sharedPreferences.getString("phone");
    pfp = services.sharedPreferences.getString("pfp");
    banner = services.sharedPreferences.getString("banner");
    approve = services.sharedPreferences.getString("approve") == "1";
    getTotalOrdersCount();

    super.onInit();
  }

  @override
  getTotalOrdersCount() async {
    data.clear();
    statusRequest = StatusRequest.loding;
    update();
    var response = await profileData
        .getCountOrders(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        data = response['data'];
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToUnDeliverdOrders() {
    Get.to(
      () => PendingOrders(),
      transition: Transition.downToUp,
      duration: Duration(milliseconds: 800),
    );
  }

  @override
  goToArchivedOrder() {
    Get.to(
      () => ArchivedOrders(),
      transition: Transition.downToUp,
      duration: Duration(milliseconds: 800),
    );
  }
}
