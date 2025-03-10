import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/favourites/favouritesdata.dart';

abstract class FavouritesController extends GetxController {
  Map favourites = {};
  setFavourites(int id, int value);
  addFavourites(int itemId);
  deleteFavourites(int itemId);
}

class FavouritesControllerImp extends FavouritesController {
  late StatusRequest statusRequest;
  Services services = Get.find();
  FavouritesData favouritesData = FavouritesData(Get.find());

  @override
  setFavourites(id, value) {
    favourites[id] = value;
    update();
  }

  @override
  addFavourites(int itemId) async {
    statusRequest = StatusRequest.loding;
    var response = await favouritesData.favouritesAdd(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.rawSnackbar(title: "yes");
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  deleteFavourites(int itemId) async {
    statusRequest = StatusRequest.loding;
    var response = await favouritesData.favouritesDelete(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.rawSnackbar(title: "no");
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }
}
