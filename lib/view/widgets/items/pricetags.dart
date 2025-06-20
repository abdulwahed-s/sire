import 'package:flutter/material.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/view/widgets/items/finalpricetag.dart';
import 'package:sire/view/widgets/items/originalpricetag.dart';

class PriceTags extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const PriceTags({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (controller.data.itemDiscount! > 0)
          OriginalPriceTag(price: controller.data.itemPrice!),
        FinalPriceTag(price: controller.data.itemFinalPrice!),
      ],
    );
  }
}