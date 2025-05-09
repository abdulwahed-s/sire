import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/items/addreviewbutton.dart';
import 'package:sire/view/widgets/items/form.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsDetailsControllerImp controller = Get.put(ItemsDetailsControllerImp());

    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Appcolor.black,
        elevation: 0,
        title: Text(
          'Product Details',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ItemsDetailsControllerImp>(
        builder: (controller) => Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildProductImage(controller, context),
                ),
                SliverToBoxAdapter(
                  child: _buildProductInfo(controller, context),
                ),
                SliverToBoxAdapter(
                  child: _buildReviewSection(controller, context),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
            if (controller.allRating.isEmpty &&
                controller.ratingStatusRequest != StatusRequest.loding)
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 65,
                  ),
                  // alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "This product has no reviews yet",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomSheet: _buildBottomBar(controller),
    );
  }

  Widget _buildProductImage(
      ItemsDetailsControllerImp controller, BuildContext context) {
    return Hero(
      tag: controller.data.itemId!,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Appcolor.black,
              Appcolor.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: AppLink.itemimage + controller.data.itemImg!,
                fit: BoxFit.contain,
                height: 280,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Appcolor.deepRed,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  "${controller.data.itemFinalPrice?.toStringAsFixed(2)}\$",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sw",
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductInfo(
      ItemsDetailsControllerImp controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.data.itemName!,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Appcolor.black,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.data.itemDesc!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 24),
          _buildQuantitySelector(controller),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(ItemsDetailsControllerImp controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: controller.isOrdered
              ? MovingGradientReviewButton(
                  key: ValueKey('review_button'),
                  onPressed: () => _showReviewDialog(controller),
                )
              : SizedBox(key: ValueKey('empty')),
        ),
        Row(
          children: [
            Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: Appcolor.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(94, 0, 0, 0), blurRadius: 6),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.pink.withValues(alpha: 0.3),
                    onTap: () {
                      controller.add();
                    },
                    child: Icon(Icons.add_rounded)),
              ),
            ),
            SizedBox(width: 13),
            Text(
              "${controller.counter}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Sw",
              ),
            ),
            SizedBox(width: 13),
            Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: Appcolor.white,
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(94, 0, 0, 0),
                        blurRadius: 6),
                  ],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      controller.remove();
                    },
                    borderRadius: BorderRadius.circular(100),
                    splashColor: Colors.pink.withValues(alpha: 0.3),
                    child: Icon(Icons.remove_rounded),
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewSection(
      ItemsDetailsControllerImp controller, BuildContext context) {
    if (controller.ratingStatusRequest == StatusRequest.loding) {
      return _buildReviewSectionSkeleton(context);
    } else if (controller.allRating.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Customer Reviews",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              InkWell(
                onTap: () {}, // TODO: Navigate to all reviews
                child: Text(
                  "See All",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Appcolor.amaranthpink,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Colors.amber, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      double.parse(controller.data.itemAvgRating!)
                          .toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(${controller.allRating.length} reviews)",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildFeaturedReview(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSectionSkeleton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 150,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 60,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturedReviewSkeleton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedReview(ItemsDetailsControllerImp controller) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                AppLink.pfpimage + controller.allRating[0].userPfp!,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.allRating[0].userName!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RatingBarIndicator(
                        rating:
                            double.parse(controller.allRating[0].ratingStars!),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 16,
                      ),
                    ],
                  ),
                  Text(
                    Jiffy.parse(controller.allRating[0].ratingDatetime!)
                        .fromNow(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.allRating[0].ratingComment!,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturedReviewSkeleton() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 120,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 200,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(ItemsDetailsControllerImp controller) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity, 
          height: 70,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.amaranthpink,
              shape: BeveledRectangleBorder(),
              elevation: 3,
            ),
            onPressed: () {
              controller.addCart("${controller.data.itemId}");
            },
            child: const Text(
              "Add To Cart",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showReviewDialog(ItemsDetailsControllerImp controller) {
    Get.dialog(
      AlertDialog(
        title: const Text('Leave a Review',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.pink)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('How would you rate your experience?',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Center(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 42,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
                  glow: true,
                  glowColor: Appcolor.amaranthpink.withValues(alpha: 0.3),
                  unratedColor: Colors.grey[300],
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Appcolor.amaranthpink,
                    size: 42,
                  ),
                  onRatingUpdate: (rating) {
                    controller.stars = rating;
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text('Share more about your experience',
                  style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              AnimatedCommentField(
                controller: controller.comment!,
                key: controller.commentKey,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.amaranthpink,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    if (controller.comment!.text == "") {
                      controller.commentKey.currentState?.triggerShake();
                      Get.snackbar(
                        'Required',
                        'Please write your review',
                        colorText: Appcolor.charcoalGray,
                        backgroundColor: Appcolor.rosePompadour,
                        icon: const Icon(Icons.error_rounded),
                      );
                      return;
                    }

                    await controller.addRating(
                        controller.data.itemId.toString(),
                        controller.stars.toString(),
                        controller.comment!.text);
                    Get.back(); 
                  },
                  child: const Text('Submit Review',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
