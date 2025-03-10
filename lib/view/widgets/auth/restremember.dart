import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class Restremember extends StatelessWidget {
  final void Function()? onTap;

  const Restremember({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTileTheme(
            horizontalTitleGap: 0.0,
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Appcolor.rosePompadour,
              title: Text("Remember me"),
              value: true,
              onChanged: (value) {},
            ),
          ),
        ),
        SizedBox(
          width: 55,
        ),
        InkWell(
            onTap: onTap,
            child: Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
