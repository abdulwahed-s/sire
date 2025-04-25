import 'package:get/get.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/screens/auth/login.dart';

abstract class SettingController extends GetxController {
  logout();
  goToAddress();
}

class SettingControllerImp extends SettingController {
  Services services = Get.find<Services>();

  @override
  goToAddress() {
    Get.to(() => ViewAddress(),
        transition: Transition.native, duration: Duration(seconds: 1));
  }

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
