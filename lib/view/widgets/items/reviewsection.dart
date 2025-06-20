import 'package:flutter/material.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/view/widgets/items/featuredreview.dart';
import 'package:sire/view/widgets/items/ratingsummary.dart';
import 'package:sire/view/widgets/items/reviewsectionheader.dart';
import 'package:sire/view/widgets/items/reviewsectionskeleton.dart';

class ReviewSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ReviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.ratingStatusRequest == StatusRequest.loding) {
      return ReviewSectionSkeleton();
    } else if (controller.allRating.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewSectionHeader(controller: controller),
          const SizedBox(height: 20),
          RatingSummary(controller: controller),
          const SizedBox(height: 16),
          FeaturedReview(review: controller.allRating[0]),
        ],
      ),
    );
  }
}
