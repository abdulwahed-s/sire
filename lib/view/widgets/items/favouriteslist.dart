import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sire/apilink.dart';
import 'package:sire/core/class/handlingdataview.dart';
import 'package:sire/core/constant/color.dart';

import '../../../controller/favourites/ViewFavouritesController.dart';

class FavouritesList extends StatelessWidget {
  final ViewFavouritesControllerImp controller;
  const FavouritesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: controller.fav.isEmpty
            ? Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "No Favourites",
                    style: TextStyle(
                      fontFamily: 'Sw',
                      fontSize: 20,
                      color: Appcolor.black,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: controller.fav.length,
                itemBuilder: (context, index) {
                  final itemId = controller.fav[index].itemId.toString();
                  final isDeleting = controller.isDeleting(itemId);
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: isDeleting
                        ? SizedBox.shrink()
                        : Column(
                            key: ValueKey(itemId),
                            children: [
                              Divider(endIndent: 20, indent: 20),
                              SizedBox(height: 10),
                              AnimatedOpacity(
                                opacity: isDeleting ? 0 : 1,
                                duration: Duration(milliseconds: 250),
                                child: Material(
                                  color: Appcolor
                                      .white, // Match your container background
                                  child: InkWell(
                                    splashColor: Colors.pink.withValues(
                                        alpha: 0.2), // Customize as needed
                                    onTap: () {
                                      controller.goToItemDetails(
                                          controller.fav[index]);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    bottom: 40,
                                                    right: 4),
                                                child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                        color: Appcolor.black,
                                                        fontFamily: 'Sw',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                height: 92,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Appcolor.mimiPink,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Hero(
                                                    tag: controller
                                                        .fav[index].itemId!,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          AppLink.itemimage +
                                                              controller
                                                                  .fav[index]
                                                                  .itemImg!,
                                                      height: 85,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${controller.fav[index].itemName}"),
                                                  Text(
                                                    "\$${(controller.fav[index].itemFinalPrice! + 0.00).toStringAsFixed(2)}",
                                                    style: TextStyle(
                                                      fontFamily: "Sw",
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 2),
                                                        child: Icon(
                                                          Icons.star,
                                                          color: Appcolor.pink,
                                                          size: 15,
                                                        ),
                                                      ),
                                                      Text(
                                                        (double.parse(controller
                                                                .fav[index]
                                                                .itemAvgRating!))
                                                            .toStringAsFixed(2),
                                                        style: TextStyle(
                                                          fontFamily: "Sw",
                                                          color: Appcolor.pink,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .deleteFavourites(itemId);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 5),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Appcolor.pink,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 29,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(endIndent: 20, indent: 20),
                            ],
                          ),
                  );
                },
              ));
  }
}
