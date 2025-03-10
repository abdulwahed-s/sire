import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/approutes.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/itmes/itemsdata.dart';
import 'package:sire/data/model/itemsmodel.dart';

abstract class ItemsController extends GetxController {
  getData(String catId);
  initiateData();
  changeCategory(int val, String catVal);
  goToItemDetails(ItemsModel itemModel);
}

class ItemscontrollerImp extends ItemsController {
  List categories = [];
  int? selected;
  String? catId;
  Itemsdata itemsdata = Itemsdata(Get.find());
  Services services = Get.find();

  List data = [];

  late StatusRequest statusRequest;

  @override
  getData(catId) async {
    data.clear();
    statusRequest = StatusRequest.loding;
    var response = await itemsdata.postData(
        catId, services.sharedPreferences.getString("id")!);
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

  @override
  initiateData() {
    categories = Get.arguments['categories'];
    selected = Get.arguments['selected'];
    catId = Get.arguments['catId'];
    getData(catId!);
  }

  @override
  changeCategory(val, catVal) {
    selected = val;
    catId = catVal;
    getData(catId!);
    update();
  }

  @override
  goToItemDetails(itemModel) {
    Get.toNamed(Approutes.itemDetails, arguments: {"itemsModel": itemModel});
  }

  @override
  void onInit() {
    super.onInit();
    initiateData();
  }
}
