import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/data/datasource/remote/checkout/coupondata.dart';
import 'package:sire/data/model/couponmodel.dart';

abstract class CouponController extends GetxController {
  checkCoupon();
}

class CouponControllerImp extends CouponController {
  StatusRequest statusRequest = StatusRequest.none;
  CouponData couponData = CouponData(Get.find());
  List<CouponModel> couponList = [];
  TextEditingController? couponTextEditingController;
  bool isCouponUsed = false;
  double? totalprice;
  double? subtotal;

  @override
  checkCoupon() async {
    statusRequest = StatusRequest.loding;
    update();
    var response =
        await couponData.checkCoupon(couponTextEditingController!.text);
    handlingdata(response);
    if (response["status"] == "success") {
      statusRequest = StatusRequest.success;
      List data = response["data"];
      couponList.addAll(data.map(
        (e) => CouponModel.fromJson(e),
      ));
      Get.snackbar(
        "Discount Applied! 🎉",
        "Your coupon saved you ${couponList[0].couponDiscount}% on this order!",
        colorText: Appcolor.charcoalGray,
        titleText: const Text(
          "Discount Applied! 🎉",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Sw",
            fontSize: 18,
            color: Appcolor.charcoalGray,
          ),
        ),
        messageText: Text(
          "Your coupon saved you ${couponList[0].couponDiscount}% on this order!",
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: "Sw",
            fontSize: 14,
            color: Appcolor.charcoalGray,
          ),
        ),
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.discount_outlined, color: Appcolor.charcoalGray),
        shouldIconPulse: true,
      );
      isCouponUsed = true;
      totalprice =
          totalprice! - (totalprice! * couponList[0].couponDiscount! / 100);
    } else if (response["status"] == "failure") {
      statusRequest = StatusRequest.failure;
      Get.snackbar(
        "Invalid Coupon",
        "The coupon code you entered is not valid. Please try again.",
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(
          Icons.error_outline,
          color: Appcolor.charcoalGray,
        ),
        shouldIconPulse: true,
      );
    }

    update();
  }

  @override
  void onInit() {
    couponTextEditingController = TextEditingController();
    totalprice = Get.arguments?["totalprice"] ?? 0.0;
    subtotal = Get.arguments?["totalprice"] ?? 0.0;
    super.onInit();
  }
}
