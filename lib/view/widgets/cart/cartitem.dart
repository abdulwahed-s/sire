import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class CartItem extends StatelessWidget {
  final String img;
  final String itemName;
  final String itemCategory;
  final String itemPrice;
  final String itemCount;
  final Function()? onAdd;
  final Function()? onRemove;
  const CartItem(
      {super.key,
      required this.img,
      required this.itemName,
      required this.itemCategory,
      required this.itemPrice,
      required this.itemCount,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Appcolor.whitePink,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.network(height: 90, img),
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
                        Text(
                          itemName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          itemCategory,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          itemPrice,
                          style: const TextStyle(
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
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Appcolor.lightPink,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                splashColor:
                                    Appcolor.pink.withValues(alpha: 0.1),
                                onTap: onAdd,
                                child: const Icon(
                                  Icons.add_rounded,
                                  color: Appcolor.berry,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  right: 5, left: 5, bottom: 2),
                              decoration: const BoxDecoration(),
                              child: Text(
                                itemCount,
                                style: const TextStyle(
                                    fontFamily: "Sw",
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.berry),
                              )),
                          Container(
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Appcolor.lightPink,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                splashColor:
                                    Appcolor.pink.withValues(alpha: 0.1),
                                onTap: onRemove,
                                child: const Icon(Icons.remove_rounded,
                                    color: Appcolor.berry),
                              ),
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
    );
  }
}
