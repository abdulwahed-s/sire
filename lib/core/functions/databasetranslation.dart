import 'package:get/get.dart';
import 'package:sire/core/services/services.dart';

Services services = Get.find();
databaseTranslation(en, ar, es) {
  String? langcode = services.sharedPreferences.getString('langcode');
  if (langcode == "en" || langcode == null) {
    return en;
  } else if (langcode == "ar") {
    return ar;
  } else if (langcode == "es") {
    return es;
  }
}
