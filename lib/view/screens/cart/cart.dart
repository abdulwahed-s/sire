import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

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
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xfffef0f7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Image.network(
                                height: 90,
                                "https://file.aiquickdraw.com/imgcompressed/img/compressed_eae3827b4cba33e723765441c0099a6d.webp"),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Mango Perfume Naturel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "Beauty",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const Text(
                                      "4\$",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.add_rounded,
                                          color: Color(0xffa43068),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              right: 5, left: 5, bottom: 2),
                                          decoration: const BoxDecoration(),
                                          child: const Text(
                                            "2",
                                            style: TextStyle(
                                                fontFamily: "Sw",
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffa43068)),
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 235, 235),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.remove_rounded,
                                          color: Color(0xffa43068),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 3),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
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
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xfff0e6ec),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                        "200\$",
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
                        "0\$",
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
                        "200\$",
                        style: TextStyle(
                          fontFamily: "Sw",
                          color: const Color(0xffa43068),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Material(
                    color: const Color(0xffa43068),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      splashColor: Colors.white.withOpacity(0.3),
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
            ),
          ),
        ],
      ),
    );
  }
}
