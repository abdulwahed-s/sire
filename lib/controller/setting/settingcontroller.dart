import 'package:get/get.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/view/screens/auth/login.dart';

abstract class SettingController extends GetxController {
  logout();
}

class SettingControllerImp extends SettingController {
  Services services = Get.find<Services>();

  @override
  logout() {
    services.sharedPreferences.clear();
    services.sharedPreferences.setString("step", "1");
    Get.offAll(
      () => Login(),
      transition: Transition.size,
      duration: Duration(seconds: 1),
    );
  }
}
