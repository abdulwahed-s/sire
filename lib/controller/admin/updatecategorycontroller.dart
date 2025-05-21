import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/admincategorycontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/addimage.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';
import 'package:sire/data/model/categoriesmodel.dart';

abstract class UpdateCategoryController extends GetxController {
  updateCategory();
}

class UpdateCategoryControllerImp extends UpdateCategoryController {
  TextEditingController? categoryName;
  TextEditingController? categoryNameAr;
  TextEditingController? categoryNameEs;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  AdminData adminData = AdminData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  CategoriesModel? categoriesModel;

  File? image;

  getImage() async {
    image = await uploadImage();
    update();
  }

  @override
  updateCategory() async {
    if (!formstate.currentState!.validate()) {
      return;
    }
    statusRequest = StatusRequest.loding;
    update();
    var response = await adminData.updateCategory(
      categoriesModel!.categoryId.toString(),
      categoryName!.text,
      categoryNameAr!.text,
      categoryNameEs!.text,
      image,
      categoriesModel!.categoryImg!,
    );
    statusRequest = handlingdata(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        Get.find<AdminCategoryControllerImp>().getCategories();
        Get.back();
        Get.snackbar(
          "Success",
          "Category updated successfully",
          colorText: Appcolor.charcoalGray,
          backgroundColor: Appcolor.rosePompadour,
          icon: const Icon(Icons.check_circle),
        );
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    categoriesModel = Get.arguments['categoriesModel'];
    categoryName = TextEditingController();
    categoryNameAr = TextEditingController();
    categoryNameEs = TextEditingController();
    categoryName!.text = categoriesModel!.categoryName!;
    categoryNameAr!.text = categoriesModel!.categoryNameAr!;
    categoryNameEs!.text = categoriesModel!.categoryNameEs!;

    super.onInit();
  }
}
