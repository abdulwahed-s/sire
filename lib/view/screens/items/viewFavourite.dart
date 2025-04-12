import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/favourites/ViewFavouritesController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/items/favouriteslist.dart';

class ViewFavourite extends StatelessWidget {
  const ViewFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewFavouritesControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      body: GetBuilder<ViewFavouritesControllerImp>(
          builder: (controller) => FavouritesList(controller: controller)),
    );
  }
}
