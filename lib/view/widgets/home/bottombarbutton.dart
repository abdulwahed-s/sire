import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class BottomBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final String text;
  final bool isActive;
  const BottomBarButton(
      {super.key,
      required this.onPressed,
      required this.iconData,
      required this.text,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      child: InkWell(
      highlightColor:  Appcolor.shadowPink,
      splashColor: Appcolor.shadowPink,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData,
                color: isActive ? Appcolor.deepPink : Appcolor.black),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isActive ? Appcolor.deepPink : Appcolor.black),
            )
          ],
        ),
      ),
    );
  }
}
