import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/constant/approutes.dart';
import 'package:sire/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  Services services = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (services.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: Approutes.homescreen);
    }

    if (services.sharedPreferences.getString("step") == "3") {
      return const RouteSettings(name: Approutes.deliveryHome);
    }

     if (services.sharedPreferences.getString("step") == "4") {
      return const RouteSettings(name: Approutes.adminHome);
    }

    if (services.sharedPreferences.getString("step") == "1") {
      return const RouteSettings(name: Approutes.login);
    }
    return null;
  }
}
