import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sire/apilink.dart';
import 'package:sire/core/class/curd.dart';
import 'package:sire/core/class/statusrequest.dart';

class SettingsData {
  Curd curd;
  SettingsData(this.curd);

  updateAccountInformation(
    String id,
    String username,
    String email,
    String phonenumber,
    String password,
    String oldpfp,
    String oldbanner,
    File? pfp,
    File? banner,
  ) async {
    Either<StatusRequest, Map> resp;
    if (pfp == null && banner == null) {
      resp = await curd.postData(AppLink.updateAccountInformation, {
        "id": id,
        "username": username,
        "email": email,
        "phonenumber": phonenumber,
        "password": password,
        "oldpfp": oldpfp,
        "oldbanner": oldbanner,
      });
    } else {
      resp = await curd.addRequestWithTwoImages(
        AppLink.updateAccountInformation,
        {
          "id": id,
          "username": username,
          "email": email,
          "phonenumber": phonenumber,
          "password": password,
          "oldpfp": oldpfp,
          "oldbanner": oldbanner,
        },
        pfp,
        banner,
      );
    }

    return resp.fold((s) => s, (r) => r);
  }
}
