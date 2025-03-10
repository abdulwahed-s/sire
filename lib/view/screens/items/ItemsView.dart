import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/favourites/favouritesController.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/core/class/handlingdatareq.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/items/CategorieslistItems.dart';
import 'package:sire/view/widgets/items/customitemslist.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemscontrollerImp());
    FavouritesControllerImp favouritesController =
        Get.put(FavouritesControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        body: GetBuilder<ItemscontrollerImp>(
          builder: (controller) {
            return HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    CategorieslistItems(),
                    GridView.builder(
                        itemCount: controller.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 5),
                        itemBuilder: (context, index) {
                          favouritesController.favourites[controller.data[index]
                                  ["item_id"]] =
                              controller.data[index]["favourite"];
                          return CustomItemsList(
                              itemsModel:
                                  ItemsModel.fromJson(controller.data[index]));
                        })
                  ],
                ));
          },
        ));
  }
}
