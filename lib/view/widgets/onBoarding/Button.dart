import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/OnBoardingController.dart';
import 'package:sire/core/constant/color.dart';

class OBButton extends GetView<OnBoardingControllerImp> {
  const OBButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 120,
          ),
          foregroundColor: Appcolor.white,
          backgroundColor: Appcolor.amaranthpink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onPressed: () {
        controller.next();
      },
      child: Text(
        "11".tr,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Appcolor.white)
      ),
    );
  }
}
