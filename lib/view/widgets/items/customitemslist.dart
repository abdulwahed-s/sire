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
        color: const Color.fromARGB(255, 255, 242, 254),
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
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                          "\$${itemsModel.itemFinalPrice?.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontFamily: "Sw",
                              fontSize: 20,
                              color: itemsModel.itemDiscount! > 0
                                  ? Appcolor.deepPurple
                                  : Appcolor.deepPink),
                        ),
                      ),
                      if (itemsModel.itemDiscount! > 0)
                        Container(
                          margin: EdgeInsets.only(top: 6, left: 3, right: 3),
                          child: Text(
                            "\$${itemsModel.itemPrice?.toInt()}",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: "Sw",
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                color: Appcolor.deepPink),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(
                  width: 45,
                ),
                GetBuilder<FavouritesControllerImp>(
                  builder: (controller) => InkWell(
                    onTap: () {
                      if (controller.favourites[itemsModel.itemId] == 1) {
                        controller.setFavourites(itemsModel.itemId!, 0);
                        controller
                            .deleteFavourites(itemsModel.itemId!.toString());
                      } else {
                        controller.setFavourites(itemsModel.itemId!, 1);
                        controller.addFavourites(itemsModel.itemId!.toString());
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
