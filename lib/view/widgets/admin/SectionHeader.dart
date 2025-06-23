import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Appcolor.berry,
      ),
    );
  }
}
