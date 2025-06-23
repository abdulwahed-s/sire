import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/cart/cartController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/cart/cartfloatingbutton.dart';
import 'package:sire/view/widgets/cart/cartitem.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartControllerImp());
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Appcolor.white,
      ),
      body: GetBuilder<CartControllerImp>(
        builder: (controller) => Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  controller.data.isNotEmpty
                      ? Column(
                          children: List.generate(
                            controller.data.length,
                            (index) => CartItem(
                              img: AppLink.itemimage +
                                  controller.data[index].itemImg!,
                              itemName: controller.data[index].itemName!,
                              itemCategory:
                                  controller.data[index].categoryName!,
                              itemPrice: controller.data[index].itemFinalPrice!
                                  .toStringAsFixed(2),
                              itemCount:
                                  controller.data[index].countitems.toString(),
                              onAdd: () => controller.add(
                                  "${controller.data[index].itemId}", index),
                              onRemove: () => controller.remove(
                                  "${controller.data[index].itemId}", index),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              height: 300,
                              // width: 300,
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                textAlign: TextAlign.justify,
                                "Your cart is empty 🛒",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.pink),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Tooltip(
                  message: controller.isNotVerified
                      ? "Please verify your account to place an order"
                      : "Place Order",
                  child: CartFloatingButton(
                      statusRequest: controller.statusRequest,
                      price: controller.data.isNotEmpty
                          ? controller.totalprice
                          : 0,
                      shippingPrice: 100,
                      isDisabled:
                          controller.data.isEmpty || controller.isNotVerified,
                      onTap: () {
                        controller.placeOrder();
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
