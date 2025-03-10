import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sire/controller/resetpassword/verifyCodeController.dart';
import 'package:sire/core/class/handlingdatareq.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/auth/appbar.dart';
import 'package:sire/view/widgets/auth/button.dart';
import 'package:sire/view/widgets/auth/titleText.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    Color accentPurpleColor = Color(0xFF6A53A1);
    Color accentPinkColor = Color(0xFFF99BBD);
    Color accentDarkGreenColor = Color(0xFF115C49);
    Color accentYellowColor = Color(0xFFFFB612);
    Color accentOrangeColor = Color(0xFFEA7A3B);

    ;

    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.displaySmall
          ?.copyWith(color: color, fontFamily: "Sw");
    }

    String codes = "";

    Get.put(VerifyCodeControllerImp());
    return Scaffold(
        backgroundColor: Appcolor.white,
        appBar: AUTHAppbar(
            text: 'Verification',
            controller: Get.find<VerifyCodeControllerImp>(),
            statusRequest: (controller) => controller.statusRequest),
        body: GetBuilder<VerifyCodeControllerImp>(
          builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10),
                  AUTHTText(text: 'Enter verification code'),
                  SizedBox(height: 50),
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: accentPurpleColor,
                    focusedBorderColor: Appcolor.lightblue,
                    styles: [
                      createStyle(accentPurpleColor),
                      createStyle(accentYellowColor),
                      createStyle(accentDarkGreenColor),
                      createStyle(accentOrangeColor),
                      createStyle(accentPinkColor),
                      createStyle(accentPurpleColor),
                    ],
                    showFieldAsBox: false,
                    borderWidth: 4.0,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      codes = code;
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      controller.verifyCode(verificationCode);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AUTHButton(
                    text: "Submit",
                    ontap: () {
                      controller.verifyCode(codes);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
