import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/favourites/ViewFavouritesController.dart';
import 'package:sire/core/constant/color.dart';

class ViewFavourite extends StatelessWidget {
  const ViewFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewFavouritesControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        body: GetBuilder<ViewFavouritesControllerImp>(
            builder: (controller) => ListView.builder(
                  itemCount: controller.fav.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Divider(
                          endIndent: 20,
                          indent: 20,
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Appcolor.white),
                            // margin: EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, bottom: 40, right: 4),
                                      child: Text((index + 1).toString(),
                                          style: TextStyle(
                                              color: Appcolor.black,
                                              fontFamily: 'Sw',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 92,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Appcolor.mimiPink,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: AppLink.itemimage +
                                              controller.fav[index].itemImg!,
                                          height: 85,
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
                                          "\$${(controller.fav[index].itemPrice! + 0.00).toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontFamily: "Sw",
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Icon(
                                                Icons.star,
                                                color: Appcolor.pink,
                                                size: 15,
                                              ),
                                            ),
                                            Text("4.9"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.deleteFavourites(controller
                                        .fav[index].itemId
                                        .toString());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Appcolor.pink,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size: 29,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(height: 10),
                        Divider(
                          endIndent: 20,
                          indent: 20,
                        ),
                      ],
                    );
                  },
                )));
  }
}
