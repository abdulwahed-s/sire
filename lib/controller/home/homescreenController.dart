import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sire/view/screens/home/home.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentpage = 0;
  List<Widget> listpages = [
    Home(),
    Center(
      child: Text("profile"),
    ),
    Center(
      child: Text("Setton"),
    ),
    Center(
      child: Text("sdasd"),
    ),
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

  @override
  changePage(int i) {
    currentpage = i;
    update();
  }
}
