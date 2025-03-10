import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/OnBoardingController.dart';
import 'package:sire/data/datasource/static/static.dart';

class OBSlider extends GetView<OnBoardingControllerImp> {
  const OBSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingList = getOnBoardingList();
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: OnBoardingList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Text(
              OnBoardingList[index].title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              OnBoardingList[index].image,
              height: 350,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(OnBoardingList[index].content,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
            )
          ],
        );
      },
    );
  }
}
