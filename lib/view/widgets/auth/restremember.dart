import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class Restremember extends StatelessWidget {
  final void Function()? onTap;
  final bool rememberMe;
  final void Function(bool? value)? onChanged;

  const Restremember(
      {super.key,
      required this.onTap,
      required this.rememberMe,
      required this.onChanged});

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
              title: const FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text("Remember me"),
              ),
              value: rememberMe,
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(
          width: 55,
        ),
        InkWell(
            onTap: onTap,
            child: Text(
              "Forgot Password",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
