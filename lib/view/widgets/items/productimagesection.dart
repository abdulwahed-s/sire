import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/items/discountbadge.dart';
import 'package:sire/view/widgets/items/pricetags.dart';

class ProductImageSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductImageSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: controller.data.itemId!,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.grey[100]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.7],
          ),
        ),
        child: Stack(
          children: [
            // Main product image
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: CachedNetworkImage(
                  imageUrl: AppLink.itemimage + controller.data.itemImg!,
                  fit: BoxFit.contain,
                  height: 280,
                  placeholder: (context, url) => const SizedBox(
                    height: 280,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.amaranthpink,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 280,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.error, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),

            // Price tags with improved design
            Positioned(
              bottom: 30,
              right: 20,
              child: PriceTags(controller: controller),
            ),

            // Discount badge
            if (controller.data.itemDiscount! > 0)
              Positioned(
                top: 100,
                left: 20,
                child: DiscountBadge(discount: controller.data.itemDiscount!),
              ),
          ],
        ),
      ),
    );
  }
}
