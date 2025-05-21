import 'dart:io';

import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';

class AdminData {
  Curd curd;
  AdminData(this.curd);
  getCategories() async {
    var resp = await curd.postData(AppLink.getCategories, {});
    return resp.fold((s) => s, (r) => r);
  }

  addCategory(
    String categoryName,
    String categoryNameAr,
    String categoryNameEs,
    File file,
  ) async {
    var resp = await curd.addRequestWithImageOne(
      AppLink.addCategories,
      {
        "nameen": categoryName,
        "namear": categoryNameAr,
        "namees": categoryNameEs,
      },
      file,
    );
    return resp.fold((s) => s, (r) => r);
  }

  deleteCategory(String id, String imgname) async {
    var resp = await curd.postData(AppLink.deleteCategories, {
      "id": id,
      "imgname": imgname,
    });
    return resp.fold((s) => s, (r) => r);
  }

  updateCategory(
    String id,
    String categoryName,
    String categoryNameAr,
    String categoryNameEs,
    File? file,
    String oldimg,
  ) async {
    var resp;
    if (file == null) {
      resp = await curd.postData(AppLink.updateCategories, {
        "id": id,
        "nameen": categoryName,
        "namear": categoryNameAr,
        "namees": categoryNameEs,
      });
    } else {
      resp = await curd.addRequestWithImageOne(
        AppLink.updateCategories,
        {
          "id": id,
          "nameen": categoryName,
          "namear": categoryNameAr,
          "namees": categoryNameEs,
          "oldimg": oldimg,
        },
        file,
      );
    }

    return resp.fold((s) => s, (r) => r);
  }
}
