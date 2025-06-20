import 'package:flutter/material.dart';

class OriginalPrice extends StatelessWidget {
  final String price;

  const OriginalPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "\$$price",
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          color: Colors.grey.shade600,
          fontSize: 14,
          fontFamily: "Sw",
        ),
      ),
    );
  }
}
