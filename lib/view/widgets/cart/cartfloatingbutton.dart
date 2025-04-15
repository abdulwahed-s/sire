import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class CartFloatingButton extends StatelessWidget {
  final int price;
  final int shippingPrice;
  final void Function()? onTap;
  const CartFloatingButton(
      {super.key, required this.price, required this.shippingPrice, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Appcolor.dustyPink,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Appcolor.blackShadow,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Amount Price"),
              Text(
                "$price\$",
                style: TextStyle(
                  fontFamily: "Sw",
                  color: Appcolor.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Shipping Price"),
              Text(
                "$shippingPrice\$",
                style: TextStyle(
                  fontFamily: "Sw",
                  color: Appcolor.black,
                ),
              ),
            ],
          ),
          const Divider(
            color: Appcolor.black,
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${price + shippingPrice}\$",
                style: TextStyle(
                  fontFamily: "Sw",
                  color: Appcolor.berry,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Material(
            color: Appcolor.berry,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              splashColor: Appcolor.shadowWhite,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
