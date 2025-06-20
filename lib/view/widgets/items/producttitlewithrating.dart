import 'package:flutter/material.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/view/widgets/items/ratingbadge.dart';

class ProductTitleWithRating extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductTitleWithRating({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            controller.data.itemName!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
          ),
        ),
        if (controller.data.itemAvgRating != null &&
            controller.data.itemAvgRating != "0")
          RatingBadge(rating: controller.data.itemAvgRating!),
      ],
    );
  }
}
