import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/data/model/itemsmodel.dart';
import 'package:sire/view/widgets/home/hotdealsheader.dart';
import 'package:sire/view/widgets/home/itemcard.dart';

class ItemsList extends GetView<HomeControllerImp> {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Header Section
          HotDealsHeader(),
          SizedBox(height: 20),

          // Enhanced Grid with Staggered Layout
          MasonryGridView.count(
            itemCount: controller.items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemBuilder: (context, index) => ItemCard(
              itemsModel: ItemsModel.fromJson(controller.items[index]),
              onTap: () {
                controller.goToItemDetails(
                    ItemsModel.fromJson(controller.items[index]));
              },
              colorIndex: index % controller.gradientColors.length,
            ),
          ),
        ],
      ),
    );
  }
}
