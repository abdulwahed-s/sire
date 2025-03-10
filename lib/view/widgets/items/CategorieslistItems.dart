import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/items/itemsController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/categoriesmodel.dart';

class CategorieslistItems extends GetView<ItemscontrollerImp> {
  const CategorieslistItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 17,
        ),
        itemBuilder: (context, index) {
          return Categories(
            selected: index,
            categoriesmodel:
                CategoriesModel.fromJson(controller.categories[index]),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class Categories extends GetView<ItemscontrollerImp> {
  final CategoriesModel categoriesmodel;
  final int selected;
  const Categories({
    super.key,
    required this.categoriesmodel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemscontrollerImp>(builder: (controller) {
      return InkWell(
        onTap: () {
          controller.changeCategory(
              selected, (categoriesmodel.categoryId!.toString()));
        },
        child: Text(
          databaseTranslation(categoriesmodel.categoryName!,
              categoriesmodel.categoryNameAr!, categoriesmodel.categoryNameEs!),
          textAlign: TextAlign.center,
          style: controller.selected == selected
              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Appcolor.rosePompadour,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)
              : Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Appcolor.black, fontSize: 15),
        ),
      );
    });
  }
}
