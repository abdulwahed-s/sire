import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class AUTHBText extends StatelessWidget {
  final String text;
  const AUTHBText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Appcolor.deepcyan),
      textAlign: TextAlign.center,
    );
  }
}
