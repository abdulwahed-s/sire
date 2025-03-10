import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/home/homedata.dart';
import 'package:sire/view/screens/items/ItemsView.dart';

abstract class HomeController extends GetxController {
  intiialiData();
  getData();
  goToItem(List categories, int selected, String catId);
}

class HomeControllerImp extends HomeController {
  Services services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.find());
  List categories = [];
  List items = [];

  String? username;
  String? id;

  @override
  intiialiData() {
    username = services.sharedPreferences.getString("username");
    id = services.sharedPreferences.getString("id");
  }

  @override
  void onInit() {
    intiialiData();
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await homeData.postData();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        categories.addAll(response['categories']);
        items.addAll(response['items']);
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToItem(categories, selected, catId) {
    Get.to(() => ItemsView(),
        transition: Transition.native,
        duration: Duration(seconds: 1),
        arguments: {
          "categories": categories,
          "selected": selected,
          "catId": catId
        });
  }
}
