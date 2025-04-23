import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sire/controller/cart/cartController.dart';
import 'package:sire/controller/favourites/ViewFavouritesController.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/controller/setting/settingcontroller.dart';
import 'package:sire/view/screens/home/home.dart';
import 'package:sire/view/screens/items/viewFavourite.dart';
import 'package:sire/view/screens/settings/settings.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listpages = [
    Home(),
    ViewFavourite(),
    Center(
      child: Text("Setton"),
    ),
    Settings()
  ];
  List<String> namepages = [
    "Home",
    "Favorite",
    "Profile",
    "Setting",
  ];
  List<IconData> iconpages = [
    Icons.home_outlined,
    Icons.favorite_outline,
    Icons.person_outline,
    Icons.settings_outlined,
  ];

  List<Type> controllerPages = [
    HomeControllerImp,
    ViewFavouritesControllerImp,
    // ProfileControllerImp,
    SettingControllerImp,
  ];

  @override
  void removeController(int i) {
    for (int j = 0; j < controllerPages.length; j++) {
      if (j != i) {
        final type = controllerPages[j];
        if (type == HomeControllerImp) {
          Get.delete<HomeControllerImp>();
        } else if (type == ViewFavouritesControllerImp) {
          Get.delete<ViewFavouritesControllerImp>();
        } //else if (type == ProfileControllerImp) {
        //  Get.delete<ProfileControllerImp>();}
        else if (type == SettingControllerImp) {
          Get.delete<SettingControllerImp>();
        }
      }
    }
  }

  @override
  changePage(int i) {
    currentpage = i;
    removeController(i);
    update();
  }
}
