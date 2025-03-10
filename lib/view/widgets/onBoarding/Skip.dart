import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/OnBoardingController.dart';

class OBSkip extends GetView<OnBoardingControllerImp> {
  const OBSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.skip();
      },
      child: Text(
        "12".tr,
        style:Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
