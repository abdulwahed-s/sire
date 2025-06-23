import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/OnBoardingController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/alertexitapp.dart';
import 'package:sire/core/localization/changelocale.dart';
import 'package:sire/view/widgets/locale/Appbar.dart';
import 'package:sire/view/widgets/onBoarding/Button.dart';
import 'package:sire/view/widgets/onBoarding/Dots.dart';
import 'package:sire/view/widgets/onBoarding/Skip.dart';
import 'package:sire/view/widgets/onBoarding/Slider.dart';

class OnBoarding extends GetView<Localecontroller> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: const LCAppBar(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          alertExitApp();
        },
        child: const SafeArea(
            child: Column(
          children: [
            Expanded(flex: 4, child: OBSlider()),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OBDots(),
                  Column(
                    children: [
                      OBButton(),
                      OBSkip(),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
