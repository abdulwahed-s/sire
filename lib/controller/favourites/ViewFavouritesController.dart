import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/favourites/favouritesdata.dart';
import 'package:sire/data/datasource/remote/favourites/viewfavouritesdata.dart';
import 'package:sire/data/model/viewfavouritesmodel.dart';

abstract class ViewFavouritesController extends GetxController {
  deleteFavourites(String itemId);
  viewFavourites();
}

class ViewFavouritesControllerImp extends ViewFavouritesController {
  late StatusRequest statusRequest;
  Services services = Get.find();
  ViewFavouritesData viewFavouritesData = ViewFavouritesData(Get.find());
  List<ViewFavouritesModel> fav = [];
  FavouritesData favouritesData = FavouritesData(Get.find());

  @override
  viewFavourites() async {
    fav.clear();
    statusRequest = StatusRequest.loding;
    var response = await viewFavouritesData
        .viewFavouritesData(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List responseData = response["data"];
        fav.addAll(responseData.map(
          (e) => ViewFavouritesModel.fromJson(e),
        ));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
      update();
    }
  }

  @override
  deleteFavourites(String itemId) {
     favouritesData.favouritesDelete(
        services.sharedPreferences.getString("id")!, itemId);
    fav.removeWhere((element) => element.itemId.toString() == itemId);
    update();
  }

  @override
  void onInit() {
    viewFavourites();
    super.onInit();
  }
}
