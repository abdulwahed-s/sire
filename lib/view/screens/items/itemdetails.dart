import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/favourites/favouritesController.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/view/widgets/items/bottombar.dart';
import 'package:sire/view/widgets/items/noreviewsoverlay.dart';
import 'package:sire/view/widgets/items/productdetailsappbartitle.dart';
import 'package:sire/view/widgets/items/productimagesection.dart';
import 'package:sire/view/widgets/items/productinfocard.dart';
import 'package:sire/view/widgets/items/reviewsection.dart';
import 'package:sire/view/widgets/items/sharebutton.dart';
import 'package:sire/view/widgets/items/specificationscard.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsDetailsControllerImp controller = Get.put(ItemsDetailsControllerImp());
    Get.lazyPut(() => FavouritesControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const ProductDetailsAppBarTitle(),
        centerTitle: true,
        actions: [ShareButton(controller: controller)],
      ),
      body: GetBuilder<ItemsDetailsControllerImp>(
        builder: (controller) => Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: ProductImageSection(controller: controller),
                ),
                SliverToBoxAdapter(
                  child: ProductInfoCard(controller: controller),
                ),
                SliverToBoxAdapter(
                  child: SpecificationsCard(controller: controller),
                ),
                SliverToBoxAdapter(
                  child: ReviewSection(controller: controller),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120),
                ),
              ],
            ),
            if (controller.allRating.isEmpty &&
                controller.ratingStatusRequest != StatusRequest.loding)
              const NoReviewsOverlay(),
          ],
        ),
      ),
      bottomSheet: BottomBar(controller: controller),
    );
  }
}
