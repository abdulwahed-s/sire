import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/auth/signUpController.dart';
import 'package:sire/core/class/handlingdatareq.dart';

import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/alertexitapp.dart';
import 'package:sire/core/functions/vaildinput.dart';
import 'package:sire/view/widgets/auth/appbar.dart';
import 'package:sire/view/widgets/auth/bodyText.dart';
import 'package:sire/view/widgets/auth/button.dart';
import 'package:sire/view/widgets/auth/doordont.dart';
import 'package:sire/view/widgets/auth/textForm.dart';
import 'package:sire/view/widgets/auth/titleText.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpcontrollerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AUTHAppbar(
          text: 'Sign up',
          controller: Get.find<SignUpcontrollerImp>(),
          statusRequest: (controller) => controller.statusRequest),
      body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            alertExitApp();
          },
          child: GetBuilder<SignUpcontrollerImp>(
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
                            const SizedBox(height: 10),
                            const AUTHTText(text: 'Welcome Back'),
                            const SizedBox(height: 10),
                            const AUTHBText(
                              text:
                                  'sign up with your email and password or continue with social media',
                            ),
                            const SizedBox(height: 50),
                            AUTHForm(
                              type: "usernam",
                              validator: (p0) {
                                return vaildInput(p0!, "username");
                              },
                              controller: controller.username,
                              label: 'Username',
                              icon: Icons.person_2_outlined,
                              hint: 'Enter your username',
                            ),
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
                            AUTHForm(
                              type: "phone",
                              validator: (p0) {
                                return vaildInput(p0!, "PhoneNumber");
                              },
                              controller: controller.phoneNumber,
                              label: 'Phone number',
                              icon: Icons.phone_android_outlined,
                              hint: 'Enter your phone number',
                            ),
                            GetBuilder<SignUpcontrollerImp>(
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
                                  icon: controller.obscureText
                                      ? Icons.lock_outlined
                                      : Icons.lock_open_outlined,
                                  hint: 'Enter your password'),
                            ),
                            AUTHButton(
                              text: "Continue",
                              ontap: () {
                                controller.signUp();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            dodont(
                              text: "already have account? ",
                              auth: "login",
                              onTap: () {
                                controller.goToLogin();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ))),
    );
  }
}
