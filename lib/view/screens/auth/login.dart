import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/auth/loginController.dart';
import 'package:sire/core/class/handlingdatareq.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/alertexitapp.dart';
import 'package:sire/core/functions/vaildinput.dart';
import 'package:sire/view/widgets/auth/appbar.dart';
import 'package:sire/view/widgets/auth/bodyText.dart';
import 'package:sire/view/widgets/auth/button.dart';
import 'package:sire/view/widgets/auth/doordont.dart';
import 'package:sire/view/widgets/auth/restremember.dart';
import 'package:sire/view/widgets/auth/textForm.dart';
import 'package:sire/view/widgets/auth/titleText.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogincontrollerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Login',
            controller: Get.find<LogincontrollerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            alertExitApp();
          },
          child: GetBuilder<LogincontrollerImp>(
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
                        SizedBox(height: 10),
                        AUTHBText(
                          text:
                              'login with your username and password or continue with social media',
                        ),
                        SizedBox(height: 50),
                        AUTHForm(
                            type: "username",
                            validator: (p0) {
                              return vaildInput(p0!, "username");
                            },
                            controller: controller.username,
                            label: 'Username',
                            icon: Icons.person_outline,
                            hint: 'Enter your username'),
                        GetBuilder<LogincontrollerImp>(
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
                        Restremember(
                          onTap: () {
                            controller.goToForgotPassword();
                          },
                        ),
                        AUTHButton(
                          text: "Continue",
                          ontap: () {
                            controller.login();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        dodont(
                          auth: "sign up",
                          text: "don't have account? ",
                          onTap: () {
                            controller.goToSignUp();
                          },
                        )
                      ],
                    ),
                  ),
                )),
          ),
        ));
  }
}
