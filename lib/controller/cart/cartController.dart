import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/cart/cartdata.dart';
import 'package:sire/data/model/cartmodel.dart';

abstract class CartController extends GetxController {
  addCart(String itemId);
  deleteCart(String itemId);
  countCart(String itemId);
  viewCart();
  add(String itemId, int index);
  remove(String itemId, int index);
}

class CartControllerImp extends CartController {
  StatusRequest statusRequest = StatusRequest.none; // Initialize with none
  CartData cartData = CartData(Get.find());
  Services services = Get.find();
  List<CartModel> data = [];
  double totalprice = 0.0;
  int countitem = 0;
  int counter = 0;

  @override
  void onInit() async {
    await viewCart();
    super.onInit();
  }

  @override
  addCart(itemId) async {
    statusRequest = StatusRequest.loding;
    update(); // Notify listeners about state change

    var response = await cartData.cartAdd(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        await viewCart(); // Refresh cart data
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
    update();
  }

  @override
  deleteCart(itemId) async {
    statusRequest = StatusRequest.loding;
    update(); // Notify listeners about state change

    var response = await cartData.cartDelete(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        await viewCart(); // Refresh cart data
        Get.snackbar(
          "Removed From Cart",
          "This item has been successfully removed from your cart.",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.remove_shopping_cart_rounded),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  countCart(String itemId) async {
    statusRequest = StatusRequest.loding;
    update();

    var response = await cartData.cartCount(
        services.sharedPreferences.getString("id")!, itemId);
    statusRequest = handlingdata(response);
    int counter = 0;

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        counter = response["data"];
      }
    }
    update();
    return counter;
  }

  @override
  viewCart() async {
    statusRequest = StatusRequest.loding;
    update();

    var response =
        await cartData.cartView(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);

    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        data.clear(); // Clear previous data
        if (response["datacart"].runtimeType != String) {
          List dataresponse = response["datacart"];
          Map dataresponsecountprice = response["totalCountAndPrice"];
          data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
          totalprice = dataresponsecountprice["carttotal"].toDouble();
          countitem = int.parse(dataresponsecountprice["itemstotal"]);
        }
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  add(itemId, index) async {
    counter = data[index].countitems!;
    await addCart(itemId);
    if (statusRequest == StatusRequest.success) {
      counter++;
      data[index].countitems = counter;
      update();
    }
  }

  @override
  remove(itemId, index) async {
    counter = data[index].countitems!;
    if (counter > 1) {
      await deleteCart(itemId);
      if (statusRequest == StatusRequest.success) {
        counter--;
        data[index].countitems = counter;
        update();
      }
    } else if (counter <= 1) {
        data.removeAt(index);
      await deleteCart(itemId);
      if (statusRequest == StatusRequest.success) {
      
        update();
      }
    }
  }
}
