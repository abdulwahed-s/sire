import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/cart/cartfloatingbutton.dart';
import 'package:sire/view/widgets/cart/cartitem.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.white,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Appcolor.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CartItem(
                  img:
                      "https://file.aiquickdraw.com/imgcompressed/img/compressed_eae3827b4cba33e723765441c0099a6d.webp",
                  itemName: 'test',
                  itemCategory: 'test',
                  itemCount: '2',
                  itemPrice: '2',
                ),
                const SizedBox(height: 300),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CartFloatingButton(
                price: 100,
                shippingPrice: 100,
                onTap: () {
                  
                },
              )),
        ],
      ),
    );
  }
}
