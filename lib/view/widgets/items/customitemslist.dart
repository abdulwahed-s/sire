import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/favourites/favouritesController.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/itemsmodel.dart';

class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  const CustomItemsList({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItemDetails(itemsModel);
      },
      child: Card(
        child: Column(
          children: [
            Hero(
              tag: itemsModel.itemId!,
              child: CachedNetworkImage(
                  height: 200,
                  imageUrl: AppLink.itemimage + itemsModel.itemImg!),
            ),
            Text(
              databaseTranslation(itemsModel.itemName!, itemsModel.itemNameAr!,
                  itemsModel.itemNameEs!),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
            SizedBox(
              height: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  () {
                    double price = itemsModel.itemPrice!;
                    int discount = itemsModel.itemDiscount!;

                    double discountedPrice = price - (price * discount ~/ 100);

                    return "\$$discountedPrice";
                  }(),
                  style: TextStyle(
                      fontFamily: "", fontSize: 20, color: Appcolor.deepPink),
                ),
                SizedBox(
                  width: 45,
                ),
                GetBuilder<FavouritesControllerImp>(
                  builder: (controller) => InkWell(
                    onTap: () {
                      if (controller.favourites[itemsModel.itemId] == 1) {
                        controller.setFavourites(itemsModel.itemId!, 0);
                        controller.deleteFavourites(
                            controller.favourites[itemsModel.itemId]);
                      } else {
                        controller.setFavourites(itemsModel.itemId!, 1);
                        controller.addFavourites(
                            controller.favourites[itemsModel.itemId]);
                      }
                    },
                    child: Icon(controller.favourites[itemsModel.itemId] == 1
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
