import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/resetpassword/verifycodepass.dart';
import 'package:sire/view/screens/resetpassword/resetpassword.dart';

abstract class VerifyCodeController extends GetxController {
  verifyCode(String code);}

class VerifyCodeControllerImp extends VerifyCodeController {
  String? email;
  VerifyCodePassData verifyCodePassData = VerifyCodePassData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  verifyCode(code) async {
    statusRequest = StatusRequest.loding;
    update();
    var response = await verifyCodePassData.postData(email!, code);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        // data.addAll(response['data']);
        Get.to(() =>RestPassword(),
            arguments: {"email": email, "code": code},
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 800));
      } else if (response["status"] == "failure") {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: "warning!!",
            middleText: "the email you entered isn't connected to an account.");
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments["email"];
    super.onInit();
  }
}
