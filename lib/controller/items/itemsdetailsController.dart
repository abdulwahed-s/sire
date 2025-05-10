import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/cart/cartdata.dart';
import 'package:sire/data/datasource/remote/rating/ratingdata.dart';
import 'package:sire/data/model/ratingmodel.dart';
import 'package:sire/view/screens/items/viewrating.dart';
import 'package:sire/view/widgets/items/form.dart';

abstract class ItemsDetailsController extends GetxController {
  initiateData();
  addCart(String itemId);
  add();
  remove();
  addRating(String itemid, String stars, String comment);
  getRating();
  getIsOrdered();
  goToAllRating();
}

class ItemsDetailsControllerImp extends ItemsDetailsController {
  int counter = 1;
  var data;
  late StatusRequest statusRequest;
  CartData cartData = CartData(Get.find());
  Services services = Get.find();
  RatingData ratingData = RatingData(Get.find());
  TextEditingController? comment;
  final GlobalKey<AnimatedCommentFieldState> commentKey = GlobalKey();
  double stars = 3;
  List<RatingModel> allRating = [];
  bool isOrdered = false;
  late StatusRequest ratingStatusRequest;

  @override
  initiateData() async {
    statusRequest = StatusRequest.loding;
    data = Get.arguments['itemsModel'];
    statusRequest = StatusRequest.success;
    update();
  }

  @override
  addCart(itemId) async {
    statusRequest = StatusRequest.loding;
    dynamic response;
    for (int i = 0; i < counter; i++) {
      response = await cartData.cartAdd(
          services.sharedPreferences.getString("id")!, itemId);
    }
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.snackbar(
          "Added To Cart",
          "This item has been successfully added to your cart!",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.add_shopping_cart_rounded),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
  }

  @override
  add() {
    counter++;
    update();
  }

  @override
  remove() {
    if (counter > 1) {
      counter--;
      update();
    }
  }

  @override
  void onInit() {
    initiateData();
    getRating();
    getIsOrdered();
    comment = TextEditingController();
    super.onInit();
  }

  @override
  addRating(itemid, stars, comment) async {
    statusRequest = StatusRequest.loding;
    var response = await ratingData.addRating(
      services.sharedPreferences.getString("id")!,
      itemid,
      stars,
      comment,
    );
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.find<ItemscontrollerImp>().statusRequest = StatusRequest.loding;
        Get.find<ItemscontrollerImp>().getData("${data.itemCat}");
        Get.back();
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getRating() async {
    ratingStatusRequest = StatusRequest.loding;
    allRating.clear();
    var response = await ratingData.getRating(data.itemId.toString());
    ratingStatusRequest = handlingdata(response);
    if (ratingStatusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        allRating.addAll(
          data.map(
            (e) => RatingModel.fromJson(e),
          ),
        );
      } else if (response["status"] == "failure") {
        ratingStatusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  getIsOrdered() async {
    var response = await ratingData.isOrdered(
      services.sharedPreferences.getString("id")!,
      data.itemId.toString(),
    );
    if (response["status"] == "success") {
      isOrdered = true;
    } else if (response["status"] == "failure") {
      isOrdered = false;
    }
    update();
  }

  @override
  goToAllRating() {
    Get.to(
      () => ViewRating(),
      arguments: {"allRating": allRating},
    );
  }
}
