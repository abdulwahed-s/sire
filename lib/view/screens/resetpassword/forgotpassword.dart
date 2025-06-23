import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/resetpassword/forgotController.dart';
import 'package:sire/core/class/handlingdatareq.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/constant/imageasset.dart';
import 'package:sire/core/functions/vaildinput.dart';
import 'package:sire/view/widgets/auth/appbar.dart';
import 'package:sire/view/widgets/auth/button.dart';
import 'package:sire/view/widgets/auth/textForm.dart';
import 'package:sire/view/widgets/auth/titleText.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgotPasswordcontrollerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Forgot password',
            controller: Get.find<ForgotPasswordcontrollerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<ForgotPasswordcontrollerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Form(
                      key: controller.formkey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Image.asset(
                            AppImage.authforgotpassword,
                            height: 200,
                          ),
                          const SizedBox(height: 10),
                          const AUTHTText(text: 'Enter Email Address'),
                          const SizedBox(height: 50),
                          AUTHForm(
                            type: "email",
                            validator: (p0) {
                              return vaildInput(p0!, "email");
                            },
                            controller: controller.email,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            hint: 'Enter your email',
                          ),
                          AUTHButton(
                            text: "Send",
                            ontap: () {
                              controller.forgotPassword();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
