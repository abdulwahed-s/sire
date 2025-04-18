import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/cart/cartdata.dart';
import 'package:sire/data/model/itemsmodel.dart';

abstract class ItemsDetailsController extends GetxController {
  initiateData();
}

class ItemsDetailsControllerImp extends ItemsDetailsController {
  // CartControllerImp cartcontroller = Get.put(CartControllerImp());
  int counter = 1;
  late ItemsModel itemsModel;
  late StatusRequest statusRequest;
  CartData cartData = CartData(Get.find());
  Services services = Get.find();

  @override
  initiateData() async {
    statusRequest = StatusRequest.loding;
    itemsModel = Get.arguments['itemsModel'];
    statusRequest = StatusRequest.success;
    update();
  }

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

  add() {
    counter++;
    update();
  }

  remove() {
    if (counter > 1) {
      counter--;
      update();
    }
  }

  @override
  void onInit() {
    initiateData();
    super.onInit();
  }
}
