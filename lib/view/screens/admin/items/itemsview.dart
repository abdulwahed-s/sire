import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/items/viewitemscontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/FilterSortRow.dart';
import 'package:sire/view/widgets/admin/ProductsGrid.dart';
import 'package:sire/view/widgets/admin/searchbar.dart';

class AdminItemsView extends StatelessWidget {
  const AdminItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    ViewItemsControllerImp controller = Get.put(ViewItemsControllerImp());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.goToAddItem();
          },
          backgroundColor: Appcolor.berry,
          elevation: 4,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            // Search Bar
            GetBuilder<ViewItemsControllerImp>(
              builder: (controller) => AdminSearchBar(controller: controller),
            ),
            // Filter and Sort Row
            GetBuilder<ViewItemsControllerImp>(
              builder: (controller) => FilterSortRow(controller: controller),
            ),
            // Products Grid
            ProductsGrid(controller: controller),
          ],
        ),
      ),
    );
  }
}
