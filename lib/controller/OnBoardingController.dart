import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/static/static.dart';
import 'package:sire/view/screens/auth/login.dart';

abstract class OnBoardinggController extends GetxController {
  next();
  onPageChanged(int index);
  skip();
}

class OnBoardingControllerImp extends OnBoardinggController {
  final OnBoardingList = getOnBoardingList();
  late PageController pageController;
  int currentPage = 0;
  Services services = Get.find();

  @override
  next() {
    if (currentPage >= OnBoardingList.length - 1) {
      services.sharedPreferences.setString("step", "1");
      Get.offAll(() =>Login(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 800));
    } else {
      pageController.animateToPage(currentPage + 1, // Increment after using
          duration: Duration(milliseconds: 900),
          curve: Curves.easeIn);
    }
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update(); // Notify listeners
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  skip() {
    pageController.animateToPage(3,
        duration: Duration(milliseconds: 900), curve: Curves.easeIn);
  }
}
