import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/checkout/checkoutcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/screens/address/viewaddress.dart';
import 'package:sire/view/widgets/address/gradientprogressindicator.dart';
import 'package:sire/view/widgets/checkout/couponsection.dart';
import 'package:sire/view/widgets/checkout/deliverytype.dart';
import 'package:sire/view/widgets/checkout/itemview.dart';
import 'package:sire/view/widgets/checkout/paymentmethod.dart';
import 'package:sire/view/widgets/checkout/shippingaddress.dart';
import 'package:sire/view/widgets/checkout/summaryrow.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                    height: 140,
                    child: GetBuilder<CheckoutControllerImp>(
                      builder: (controller) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.orderDetails!.length,
                        itemBuilder: (context, index) {
                          return ItemView(
                              itemName:
                                  controller.orderDetails![index].itemName!,
                              itemImage: AppLink.itemimage +
                                  controller.orderDetails![index].itemImg!,
                              itemprice: controller
                                  .orderDetails![index].itemFinalPrice!
                                  .toStringAsFixed(2),
                              itmeQuantity: controller
                                  .orderDetails![index].countitems!
                                  .toString());
                        },
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 12),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => DeliveryType(
                isDelivery: controller.deliveryType == 0,
                isPickUp: controller.deliveryType == 1,
                onTapDelivery: () {
                  controller.changeDeliveryType(0);
                },
                onTapPickUp: () {
                  controller.changeDeliveryType(1);
                },
              ),
            ),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => controller.deliveryType == 1
                  ? SizedBox.shrink()
                  : Card(
                      color: Appcolor.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Shipping Address",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            if (controller.addresses.isEmpty &&
                                controller.statusRequest ==
                                    StatusRequest.loding)
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 16,
                                                width: double.infinity,
                                                color: Colors.white),
                                            SizedBox(height: 8),
                                            Container(
                                                height: 12,
                                                width: double.infinity,
                                                color: Colors.white),
                                            SizedBox(height: 4),
                                            Container(
                                                height: 12,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (controller.addresses.isEmpty &&
                                controller.statusRequest !=
                                    StatusRequest.loding)
                              Column(
                                children: [
                                  SizedBox(height: 16),
                                  Icon(
                                    Icons.location_off_outlined,
                                    size: 48,
                                    color: Colors.grey.withValues(alpha: 0.5),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "No shipping address added",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Please add an address to proceed with your order",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(
                                        () => ViewAddress(),
                                        transition: Transition.leftToRight,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Appcolor.amaranthpink,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                    child: Text(
                                      "Add Address",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ListView.builder(
                              itemCount: controller.addresses.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ShippingAddress(
                                      title: controller
                                          .addresses[index].addressName!,
                                      subTitle:
                                          "Building: ${controller.addresses[index].addressBuilding!}, "
                                          "Street: ${controller.addresses[index].addressStreet!}, "
                                          "Block: ${controller.addresses[index].addressBlock!}, "
                                          "Floor: ${controller.addresses[index].addressFloor!}.",
                                      placeName: controller
                                          .addresses[index].addressBymap!,
                                      icon: Icons.home,
                                      isSelected: controller.addressId ==
                                          controller
                                              .addresses[index].addressId!,
                                      onTap: () {
                                        controller.chooseAddressId(controller
                                            .addresses[index].addressId!);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.av_timer_rounded,
                                            size: 16,
                                            color: Appcolor.amaranthpink,
                                          ),
                                          SizedBox(width: 6),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Estimated delivery: ',
                                                  style: TextStyle(
                                                    fontFamily: "Sw",
                                                    fontSize: 13,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller
                                                      .addresses[index]
                                                      .addressDeliverytime!,
                                                  style: TextStyle(
                                                    fontFamily: "Sw",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        Appcolor.amaranthpink,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index !=
                                        controller.addresses.length - 1)
                                      Divider(height: 24, thickness: 1),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
            ),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => Card(
                color: Appcolor.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      PaymentMethod(
                        paymentName: "Cash",
                        paymentImg:
                            "https://cdn-icons-png.flaticon.com/256/745/745640.png",
                        value: 4,
                        groupValue: controller.paymentType,
                        onTap: () {
                          controller.changePaymentType(4);
                        },
                      ),
                      const SizedBox(height: 8),
                      PaymentMethod(
                        paymentName: "Visa",
                        paymentImg:
                            "https://1000logos.net/wp-content/uploads/2021/11/VISA-logo.png",
                        value: 0,
                        groupValue: controller.paymentType,
                        onTap: () {
                          controller.changePaymentType(0);
                        },
                      ),
                      const SizedBox(height: 8),
                      PaymentMethod(
                        paymentName: "mastercard",
                        paymentImg:
                            "https://brandlogos.net/wp-content/uploads/2021/11/mastercard-logo.png",
                        value: 1,
                        groupValue: controller.paymentType,
                        onTap: () {
                          controller.changePaymentType(1);
                        },
                      ),
                      const SizedBox(height: 8),
                      PaymentMethod(
                        paymentName: "American Express",
                        paymentImg:
                            "https://www.americanexpress.com/content/dam/amex/us/merchant/supplies-uplift/product/images/img-WEBLOGO1-01.jpg",
                        value: 2,
                        groupValue: controller.paymentType,
                        onTap: () {
                          controller.changePaymentType(2);
                        },
                      ),
                      const SizedBox(height: 8),
                      PaymentMethod(
                        paymentName: "PayPal",
                        paymentImg:
                            "https://upload.wikimedia.org/wikipedia/commons/a/a4/Paypal_2014_logo.png",
                        value: 3,
                        groupValue: controller.paymentType,
                        onTap: () {
                          controller.changePaymentType(3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Appcolor.white,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Have a coupon?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CouponSection(),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Appcolor.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<CheckoutControllerImp>(
                      builder: (controller) => SummaryRow(
                        label: "Subtotal",
                        value:
                            "\$${controller.couponController.subtotal!.toStringAsFixed(2)}",
                        isTotal: false,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<CheckoutControllerImp>(
                        builder: (controller) =>
                            controller.couponController.isCouponUsed
                                ? SummaryRow(
                                    label: "Discount",
                                    value:
                                        "-%${controller.couponController.couponList[0].couponDiscount}",
                                    isTotal: false,
                                  )
                                : SizedBox()),
                    const SizedBox(height: 8),
                    GetBuilder<CheckoutControllerImp>(
                      builder: (controller) => SummaryRow(
                        label: "Shipping fee",
                        value: "\$${controller.shippingFee}",
                        isTotal: false,
                      ),
                    ),
                    const Divider(height: 24, thickness: 1),
                    GetBuilder<CheckoutControllerImp>(
                      builder: (controller) => SummaryRow(
                        label: "Total amount",
                        value:
                            "\$${(controller.couponController.totalprice! + controller.shippingFee).toStringAsFixed(2)}",
                        isTotal: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<CheckoutControllerImp>(
              builder: (controller) => Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : () async {
                          await controller.placeOrder();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolor.deepPink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: controller.isLoading
                      ? SizedBox(
                          height: 25,
                          child: GradientProgressIndicator(strokeWidth: 2))
                      : Text(
                          "Complete Order",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
