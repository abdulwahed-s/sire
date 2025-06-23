import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/category/admincategorycontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/screens/admin/categories/addcategory.dart';
import 'package:sire/view/widgets/admin/categorycard.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminCategoryControllerImp());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AdminCategoryControllerImp>(
          builder: (controller) {
            if (controller.categories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.categories.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CategoryCard(controller: controller, index: index);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add New Category",
          onPressed: () {
            Get.to(() => const AddCategory());
          },
          backgroundColor: Appcolor.pink,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
