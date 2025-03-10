import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/resetpassword/RestPasswordController.dart';
import 'package:sire/core/class/handlingdatareq.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/vaildinput.dart';
import 'package:sire/view/widgets/auth/appbar.dart';
import 'package:sire/view/widgets/auth/button.dart';
import 'package:sire/view/widgets/auth/textForm.dart';
import 'package:sire/view/widgets/auth/titleText.dart';

class RestPassword extends StatelessWidget {
  const RestPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RestPasswordControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Rest Password',
            controller: Get.find<RestPasswordControllerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<RestPasswordControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Form(
                      key: controller.formkey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 10),
                          AUTHTText(text: 'Welcome Back'),
                          SizedBox(height: 50),
                          GetBuilder<RestPasswordControllerImp>(
                              builder: (controller) => AUTHForm(
                                    obscureText: controller.obscureText,
                                    onTap: () {
                                      controller.showPassword();
                                    },
                                    type: "password",
                                    validator: (p0) {
                                      return vaildInput(p0!, "password");
                                    },
                                    controller: controller.password,
                                    label: 'Password',
                                    icon: Icons.lock_outlined,
                                    hint: 'Enter your password',
                                  )),
                          GetBuilder<RestPasswordControllerImp>(
                              builder: (controller) => AUTHForm(
                                    obscureText: controller.obscureText2,
                                    onTap: () {
                                      controller.showPassword2();
                                    },
                                    type: "password",
                                    validator: (p0) {
                                      return vaildInput(p0!, "password");
                                    },
                                    controller: controller.repassword,
                                    label: 'Password',
                                    icon: Icons.lock_open_outlined,
                                    hint: 'Confirm your password',
                                  )),
                          AUTHButton(
                            text: "Continue",
                            ontap: () {
                              controller.restPassword();
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }
}
