import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/approutes.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/cart/cartdata.dart';
import 'package:sire/data/datasource/remote/itmes/itemsdata.dart';
import 'package:sire/data/model/itemsmodel.dart';

abstract class ItemsController extends GetxController {
  getData(String catId);
  initiateData();
  changeCategory(int val, String catVal);
  goToItemDetails(ItemsModel itemModel);
  addToCart(String itemId);
}

class ItemscontrollerImp extends ItemsController {
  List categories = [];
  int? selected;
  String? catId;
  Itemsdata itemsdata = Itemsdata(Get.find());
  Services services = Get.find();
  CartData cartData = CartData(Get.find());
  StatusRequest statusRequestAdd = StatusRequest.none;
  final Set<int> loadingItemIds = {};

  List data = [];

  late StatusRequest statusRequest;

  @override
  getData(catId) async {
    data.clear();
    statusRequest = StatusRequest.loding;
    update();
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

  @override
  addToCart(itemId) async {
    final id = int.parse(itemId);
    loadingItemIds.add(id);
    statusRequestAdd = StatusRequest.loding;
    update();
    try {
      dynamic response;
      response = await cartData.cartAdd(
          services.sharedPreferences.getString("id")!, itemId);
      statusRequestAdd = handlingdata(response);
      if (statusRequestAdd == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.snackbar(
            "Added To Cart",
            "This item has been successfully added to your cart!",
            colorText: Appcolor.charcoalGray,
            backgroundColor: Appcolor.rosePompadour,
            icon: const Icon(Icons.add_shopping_cart_rounded),
          );
        } else if (response["status"] == "failure") {
          statusRequestAdd = StatusRequest.failure;
        }
      }
    } catch (e) {
      statusRequestAdd = StatusRequest.failure;
      Get.snackbar(
        "Error",
        "An error occurred while adding the item to your cart.",
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.error),
      );
    } finally {
      loadingItemIds.remove(id);
      update();
    }
  }

  bool isLoadingItem(int itemId) {
    return loadingItemIds.contains(itemId);
  }
}
