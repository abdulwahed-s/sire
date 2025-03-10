import 'package:get/get.dart';
import 'package:sire/data/model/itemsmodel.dart';

abstract class ItemsDetailsController extends GetxController {
  initiateData();
}

class ItemsDetailsControllerImp extends ItemsDetailsController {
  late ItemsModel itemsModel;

  @override
  initiateData() {
    itemsModel = Get.arguments['itemsModel'];
  }

  @override
  void onInit() {
    initiateData();
    super.onInit();
  }
}
