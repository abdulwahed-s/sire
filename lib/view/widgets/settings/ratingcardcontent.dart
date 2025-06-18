import 'package:flutter/material.dart';
import 'package:sire/controller/setting/viewratingcontroller.dart';
import 'package:sire/view/widgets/settings/itemimage.dart';
import 'package:sire/view/widgets/settings/ratingdetails.dart';

class RatingCardContent extends StatelessWidget {
  final ViewRatingControllerImp controller;
  final dynamic rating;

  const RatingCardContent({
    super.key,
    required this.controller,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemImage(rating: rating),
        const SizedBox(width: 20),
        Expanded(
          child: RatingDetails(rating: rating),
        ),
      ],
    );
  }
}