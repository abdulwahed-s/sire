import 'package:flutter/material.dart';
import 'package:sire/controller/setting/viewratingcontroller.dart';
import 'package:sire/view/widgets/settings/ratingactions.dart';
import 'package:sire/view/widgets/settings/userinfosection.dart';

class RatingCardHeader extends StatelessWidget {
  final ViewRatingControllerImp controller;
  final dynamic rating;

  const RatingCardHeader({
    super.key,
    required this.controller,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // User info
        Expanded(
          child: UserInfoSection(controller: controller),
        ),
        // Action buttons
        RatingActions(
          controller: controller,
          rating: rating,
        ),
      ],
    );
  }
}
