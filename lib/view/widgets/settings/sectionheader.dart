import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Appcolor.berry,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}