import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/favourites/favouritesController.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/view/widgets/items/CategorieslistItems.dart';
import 'package:sire/view/widgets/items/categorypagecontent.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemscontrollerImp());
    FavouritesControllerImp favouritesController =
        Get.put(FavouritesControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: GetBuilder<ItemscontrollerImp>(
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 50),
              const CategorieslistItems(),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.onPageChanged(index);
                  },
                  itemCount: controller.categories.length,
                  itemBuilder: (context, pageIndex) {
                    return CategoryPageContent(
                      categoryIndex: pageIndex,
                      favouritesController: favouritesController,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
