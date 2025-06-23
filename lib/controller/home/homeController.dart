import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/home/homedata.dart';
import 'package:sire/view/screens/items/ItemsView.dart';
import 'package:sire/view/screens/items/itemdetails.dart';
import 'package:sire/view/screens/search/search.dart';

abstract class HomeController extends GetxController {
  intiialiData();
  getData();
  goToItem(List categories, int selected, String catId);
  goToSearch();
  goToItemDetails(model);
}

class HomeControllerImp extends HomeController {
  Services services = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.find());
  List categories = [];
  List items = [];
  List mainPage = [];
  TextEditingController? textEditingController;

  String? username;
  String? id;
  String? pfp;

  @override
  intiialiData() {
    username = services.sharedPreferences.getString("username");
    pfp = services.sharedPreferences.getString("pfp");
    id = services.sharedPreferences.getString("id");
  }

  @override
  void onInit() {
    textEditingController = TextEditingController();
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
        mainPage.addAll(response['mainpage']);
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

  @override
  goToSearch() {
    Get.to(Search(),
        transition: Transition.native,
        duration: Duration(seconds: 1),
        arguments: {
          "input": textEditingController!.text,
        });
  }

  @override
  goToItemDetails(model) {
    Get.to(
      () => ItemDetails(),
      transition: Transition.rightToLeftWithFade,
      duration: Duration(milliseconds: 500),
      arguments: {"itemsModel": model},
    );
  }

  List<Color> gradientColors = [
    Appcolor.hotPink,
    Appcolor.pink,
    Appcolor.purple,
    Appcolor.deepPurple,
    Appcolor.indigo,
    Appcolor.blue,
    Appcolor.cyan,
    Appcolor.teal,
    Appcolor.green,
    Appcolor.lightGreen,
    Appcolor.deepOrange,
    Appcolor.amber,
    Appcolor.yellow,
    Appcolor.brown,
    Appcolor.greyShade,
    Appcolor.charcoalGray,
    Appcolor.indigoBlue,
    Appcolor.skyBlue,
    Appcolor.blueGray,
  ];
}
