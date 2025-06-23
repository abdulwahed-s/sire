import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/home/originalprice.dart';

class PriceSection extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;

  const PriceSection({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Final Price with Animation
        Expanded(
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                "\$${itemsModel.itemFinalPrice}",
                textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sw",
                ),
                colors: [
                  Get.find<HomeControllerImp>().gradientColors[colorIndex],
                  Get.find<HomeControllerImp>().gradientColors[
                      (colorIndex + 1) %
                          Get.find<HomeControllerImp>().gradientColors.length],
                ],
                speed: const Duration(seconds: 3),
              ),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),
        ),

        // Original Price
        if (itemsModel.itemPrice != itemsModel.itemFinalPrice)
          OriginalPrice(price: itemsModel.itemPrice!.toString()),
      ],
    );
  }
}
