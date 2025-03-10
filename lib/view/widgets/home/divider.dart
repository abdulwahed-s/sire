import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class HomeDivider extends StatelessWidget {
  final String leftText;
  final String rightText;
  const HomeDivider(
      {super.key, required this.leftText, required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(leftText, style: Theme.of(context).textTheme.bodyLarge!),
        SizedBox(
          width: 100,
        ),
        Text(rightText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Appcolor.rosePompadour))
      ],
    );
  }
}
