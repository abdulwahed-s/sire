import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class AUTHButton extends StatelessWidget {
final String text;
final void Function() ontap;
  const AUTHButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          color: Appcolor.amaranthpink,
          height: 55,
          minWidth: double.infinity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed:ontap,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
