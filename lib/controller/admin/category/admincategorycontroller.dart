import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/admin/admindata.dart';
import 'package:sire/data/model/categoriesmodel.dart';
import 'package:sire/view/screens/admin/categories/updatecategory.dart';

abstract class AdminCategoryController extends GetxController {
  getCategories();
  deleteCategory(String id, String imgname);
  goToEditCategory(CategoriesModel categoriesModel);
}

class AdminCategoryControllerImp extends AdminCategoryController {
  late StatusRequest statusRequest;
  AdminData adminData = AdminData(Get.find());
  List<CategoriesModel> categories = [];

  @override
  getCategories() async {
    statusRequest = StatusRequest.loding;
    categories.clear();
    var response = await adminData.getCategories();
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        categories.addAll(data.map((e) => CategoriesModel.fromJson(e)));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  @override
  deleteCategory(String id, String imgname) async {
    adminData.deleteCategory(id, imgname);
    categories.removeWhere((element) => element.categoryId == int.parse(id));
  

    update();
  }

  @override
  goToEditCategory(CategoriesModel categoriesModel) {
    Get.to(
      () => const UpdateCategory(),
      arguments: {
        "categoriesModel": categoriesModel,
      },
      transition: Transition.leftToRightWithFade,
      duration: const Duration(milliseconds: 500),
    );
  }
}
