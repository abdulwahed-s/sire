import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/favourites/ViewFavouritesController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/items/favouriteslist.dart';

class ViewFavourite extends StatelessWidget {
  const ViewFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ViewFavouritesControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        backgroundColor: Appcolor.white,
        title: Text(
          "Favourites",
          style: TextStyle(
            fontSize: 20,
            color: Appcolor.black,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ViewFavouritesControllerImp>(
          builder: (controller) => FavouritesList(controller: controller)),
    );
  }
}
