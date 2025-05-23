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

  getItems() async {
    var resp = await curd.postData(AppLink.getItems, {});
    return resp.fold((s) => s, (r) => r);
  }

  addItem(
    String name,
    String namear,
    String namees,
    String desc,
    String descar,
    String desces,
    String count,
    String active,
    String price,
    String discount,
    String catgoryId,
    File file,
  ) async {
    var resp = await curd.addRequestWithImageOne(
      AppLink.addItems,
      {
        "name": name,
        "namear": namear,
        "namees": namees,
        "desc": desc,
        "descar": descar,
        "desces": desces,
        "count": count,
        "active": active,
        "price": price,
        "discount": discount,
        "catid": catgoryId,
      },
      file,
    );
    return resp.fold((s) => s, (r) => r);
  }

  deleteItem(String id, String imgname) async {
    var resp = await curd.postData(AppLink.deleteItems, {
      "id": id,
      "imgname": imgname,
    });
    return resp.fold((s) => s, (r) => r);
  }

  updateItem(
    String id,
    String name,
    String namear,
    String namees,
    String desc,
    String descar,
    String desces,
    String count,
    String active,
    String price,
    String discount,
    String catgoryId,
    File? file,
    String oldimg,
  ) async {
    var resp;
    if (file == null) {
      resp = await curd.postData(AppLink.updateItems, {
        "id": id,
        "name": name,
        "namear": namear,
        "namees": namees,
        "desc": desc,
        "descar": descar,
        "desces": desces,
        "count": count,
        "active": active,
        "price": price,
        "discount": discount,
        "catid": catgoryId
      });
    } else {
      resp = await curd.addRequestWithImageOne(
          AppLink.updateItems,
          {
            "id": id,
            "name": name,
            "namear": namear,
            "namees": namees,
            "desc": desc,
            "descar": descar,
            "desces": desces,
            "count": count,
            "active": active,
            "price": price,
            "discount": discount,
            "catid": catgoryId,
            "oldimg": oldimg,
          },
          file);
    }
    return resp.fold((s) => s, (r) => r);
  }
}
