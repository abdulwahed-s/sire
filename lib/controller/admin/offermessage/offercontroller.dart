import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';
import 'package:sire/view/screens/admin/offermessage/editoffer.dart';

abstract class OfferController extends GetxController {
  getOfferMessage();
  goToEditMessage();
}

class OfferControllerImp extends OfferController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List data = [];

  @override
  getOfferMessage() async {
    statusRequest = StatusRequest.loding;
    update();
    data.clear();
    var response = await adminData.getOfferMessage();
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
  void onInit() {
    getOfferMessage();
    super.onInit();
  }

  @override
  goToEditMessage() {
    Get.to(
      () => const EditOffer(),
      arguments: {"data": data},
    );
  }
}
