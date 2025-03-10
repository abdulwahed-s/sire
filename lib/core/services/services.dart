import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<Services> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp();
    return this;
  }
}

InitialServices() async {
  await Get.putAsync(() => Services().init());
}
