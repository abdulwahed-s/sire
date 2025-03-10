import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/core/constant/color.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    ItemsDetailsControllerImp controller = Get.put(ItemsDetailsControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Appcolor.white),
          backgroundColor: Appcolor.black,
        ),
        bottomNavigationBar: MaterialButton(
          color: Appcolor.amaranthpink,
          onPressed: () {},
          height: 70,
          child: Text("Add To Cart"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Appcolor.white,
                        Appcolor.black,
                      ],
                      begin: const FractionalOffset(1.0, 1.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Hero(
                    tag: controller.itemsModel.itemId!,
                    child: CachedNetworkImage(
                      imageUrl:
                          AppLink.itemimage + controller.itemsModel.itemImg!,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    controller.itemsModel.itemName!,
                    style: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    controller.itemsModel.itemDesc!,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: "sw",
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 5, 4, 59)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "12\$",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontFamily: "sw",
                        fontSize: 32,
                        color: const Color.fromARGB(255, 4, 59, 16)),
                  ),
                ),
        
              ],
            ),
            Positioned(
              top: Get.height / 1.38,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(85, 239, 240, 242),
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Appcolor.amber.withOpacity(1),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 28,
                            color: Appcolor.amber,
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Appcolor.deepPink.withOpacity(1),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 28,
                            color: Appcolor.deepPink,
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Appcolor.amaranthpink.withOpacity(1),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 28,
                            color: Appcolor.amaranthpink,
                          ),
                        ),
                        SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Appcolor.grey.withOpacity(1),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.circle,
                            size: 28,
                            color: Appcolor.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 130),
                    Row(
                      children: [
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
                          child: Icon(Icons.add_rounded),
                        ),
                        SizedBox(width: 6),
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
                          child: Center(
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: ""),
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
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
                          child: Icon(Icons.remove_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
