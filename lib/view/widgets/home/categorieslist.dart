import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/databasetranslation.dart';
import 'package:sire/data/model/categoriesmodel.dart';

class Categorieslist extends GetView<HomeControllerImp> {
  const Categorieslist({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => SizedBox(
          width: 12,
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

class Categories extends GetView<HomeControllerImp> {
  final CategoriesModel categoriesmodel;
  final int selected;
  const Categories({
    super.key,
    required this.categoriesmodel,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToItem(controller.categories, selected,
            categoriesmodel.categoryId.toString());
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Appcolor.white,
            minRadius: 30,
            child: Center(
              child: SvgPicture.network(
                  width: 40,
                  height: 40,
                  AppLink.categoriesimage + categoriesmodel.categoryImg!),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            databaseTranslation(
                categoriesmodel.categoryName!,
                categoriesmodel.categoryNameAr!,
                categoriesmodel.categoryNameEs!),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Appcolor.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
