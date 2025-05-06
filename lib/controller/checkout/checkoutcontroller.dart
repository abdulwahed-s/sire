import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sire/controller/checkout/couponcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/functions/handlingdata.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/data/datasource/remote/address/addressdata.dart';
import 'package:sire/data/datasource/remote/checkout/checkoutdata.dart';
import 'package:sire/data/model/addressmodel.dart';
import 'package:sire/data/model/cartmodel.dart';
import 'package:sire/view/screens/home/homescreen.dart';

abstract class CheckoutController extends GetxController {
  getUserAddresses();
  chooseAddressId(int id);
  changeDeliveryType(int id);
  changePaymentType(int id);
  placeOrder();
  showSnackBarIf(x, String subtitle);
}

class CheckoutControllerImp extends CheckoutController {
  CouponControllerImp couponController = Get.put(CouponControllerImp());

  int? addressId;
  int? deliveryType;
  int? paymentType;
  int shippingFee = 10;

  CheckoutData checkoutData = CheckoutData(Get.find());

  Services services = Get.find<Services>();
  AddressData addressData = AddressData(Get.find());
  List<AddressModel> addresses = [];
  late StatusRequest statusRequest;
  List<CartModel>? orderDetails;

  @override
  getUserAddresses() async {
    statusRequest = StatusRequest.loding;
    await Future.delayed(Duration(seconds: 2));

    var response = await addressData
        .getAddress(services.sharedPreferences.getString("id")!);
    statusRequest = handlingdata(response);
    if (statusRequest == StatusRequest.success) {
      if (response["status"] == "success") {
        List data = response['data'];
        addresses.addAll(data.map(
          (e) => AddressModel.fromJson(e),
        ));
      } else if (response["status"] == "failure") {}
    }
    update();
  }

  @override
  chooseAddressId(id) {
    addressId = id;
    update();
  }

  @override
  changeDeliveryType(int id) {
    deliveryType = id;
    update();
  }

  @override
  changePaymentType(id) {
    paymentType = id;
    update();
  }

  @override
  void onInit() {
    getUserAddresses();
    orderDetails = Get.arguments["orderDetails"];
    super.onInit();
  }

  @override
  showSnackBarIf(x, subtitle) {
    if (x == null) {
      Get.snackbar(
        "Oops",
        subtitle,
        colorText: Appcolor.charcoalGray,
        backgroundColor: Appcolor.rosePompadour,
        icon: const Icon(Icons.close_rounded),
        shouldIconPulse: true,
      );
      return true;
    } else {
      return false;
    }
  }

  @override
  placeOrder() async {
    if (showSnackBarIf(addressId, 'Delivery address missing') ||
        showSnackBarIf(deliveryType, "Delivery type not selected") ||
        showSnackBarIf(paymentType, "Payment method not selected")) {
      return;
    } else {
      statusRequest = StatusRequest.loding;
      var response = await checkoutData.placeOrder(
        services.sharedPreferences.getString("id")!,
        addressId!.toString(),
        deliveryType!.toString(),
        couponController.totalprice!.toString(),
        shippingFee.toString(),
        paymentType!.toString(),
        couponController.isCouponUsed
            ? couponController.couponList[0].couponId!.toString()
            : "0",
      );
      print(response);
      statusRequest = handlingdata(response);
      if (statusRequest == StatusRequest.success) {
        if (response["status"] == "success") {
          Get.offAll(() => HomeScreen());
          Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 150,
                      child: Lottie.asset(
                        "lottie/orederplaced.json",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Order Placed Successfully!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Sw",
                        color: Appcolor.amaranthpink,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Thank you for your purchase!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.amaranthpink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        "Continue Shopping",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            barrierDismissible: true,
          );
        } else if (response["status"] == "failure") {}
      }
      update();
    }
  }
}
