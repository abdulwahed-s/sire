import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/OnBoardingController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/data/datasource/static/static.dart';

class OBDots extends StatelessWidget {
  const OBDots({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(builder: (controller) {
      final onBoardingList = getOnBoardingList();
      return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      onBoardingList.length,
                      (index) {
                        return AnimatedContainer(
                          margin: const EdgeInsets.only(right: 5),
                          duration: const Duration(
                            milliseconds: 940,
                          ),
                          width: controller.currentPage==index?20:5,
                          height: 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Appcolor.rosePompadour),
                        );
                      },
                    )
                  ],
                );
    },);
  }
}