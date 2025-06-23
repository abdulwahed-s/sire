import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/home/discountbadge.dart';
import 'package:sire/view/widgets/home/pricesection.dart';

class ItemCardContent extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;
  final double discountPercentage;

  const ItemCardContent({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Get.find<HomeControllerImp>()
                          .gradientColors[colorIndex]
                          .withValues(alpha: 0.1),
                      Get.find<HomeControllerImp>()
                          .gradientColors[colorIndex]
                          .withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: AppLink.itemimage + itemsModel.itemImg!,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Get.find<HomeControllerImp>()
                          .gradientColors[colorIndex],
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
              if (discountPercentage > 0)
                Positioned(
                  top: 12,
                  right: 12,
                  child: DiscountBadge(discountPercentage: discountPercentage),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  databaseTranslation(
                    itemsModel.itemName!,
                    itemsModel.itemNameAr!,
                    itemsModel.itemNameEs!,
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                    fontFamily: "Sw",
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                PriceSection(
                  itemsModel: itemsModel,
                  colorIndex: colorIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
