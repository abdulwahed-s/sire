import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/favourites/favouritesController.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/address/gradientprogressindicator.dart';

class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  final Function()? onTap;
  final bool loading;
  const CustomItemsList({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final isDiscounted = itemsModel.itemDiscount! > 0;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        controller.goToItemDetails(itemsModel);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite button overlay
            Stack(
              children: [
                Hero(
                  tag: itemsModel.itemId!,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: CachedNetworkImage(
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      imageUrl: AppLink.itemimage + itemsModel.itemImg!,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),

                // Discount badge
                if (isDiscounted)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Appcolor.deepPurple,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${itemsModel.itemDiscount}% OFF',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GetBuilder<FavouritesControllerImp>(
                    builder: (controller) => Material(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          if (controller.favourites[itemsModel.itemId] == 1) {
                            controller.setFavourites(itemsModel.itemId!, 0);
                            controller.deleteFavourites(
                                itemsModel.itemId!.toString());
                          } else {
                            controller.setFavourites(itemsModel.itemId!, 1);
                            controller
                                .addFavourites(itemsModel.itemId!.toString());
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            controller.favourites[itemsModel.itemId] == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.favourites[itemsModel.itemId] == 1
                                ? Appcolor.deepPink
                                : Colors.grey[600],
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    databaseTranslation(itemsModel.itemName!,
                        itemsModel.itemNameAr!, itemsModel.itemNameEs!),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),

                  const SizedBox(height: 8),

                  // Rating row
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: double.parse(itemsModel.itemAvgRating!),
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 18.0,
                        direction: Axis.horizontal,
                        unratedColor: Colors.grey[300],
                      ),
                      const SizedBox(width: 6),
                      Text(
                        double.parse(itemsModel.itemAvgRating!)
                            .toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$${itemsModel.itemFinalPrice?.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontFamily: "Sw",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDiscounted
                                  ? Appcolor.deepPurple
                                  : Appcolor.deepPink,
                            ),
                          ),
                          if (isDiscounted)
                            Text(
                              "\$${itemsModel.itemPrice?.toInt()}",
                              style: TextStyle(
                                fontFamily: "Sw",
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),

                      // Add to cart button
                      Material(
                        color: Appcolor.deepPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          splashColor: Appcolor.amaranthpink,
                          onTap: onTap,
                          child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            constraints: const BoxConstraints(),
                            child: loading
                                ? SizedBox(
                                    width: 18,
                                    child: GradientProgressIndicator(
                                        strokeWidth: 2))
                                : Icon(Icons.add_shopping_cart,
                                    size: 18, color: Appcolor.deepPurple),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
