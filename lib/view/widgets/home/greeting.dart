import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/screens/items/viewFavourite.dart';

class Greeting extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  final String img;
  const Greeting({
    super.key,
    required this.name,
    required this.img,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => ViewFavourite(),
                    transition: Transition.circularReveal,
                    duration: Duration(seconds: 1),
                    fullscreenDialog: false);
              },
              child: Icon(
                Icons.favorite,
                color: Appcolor.white,
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.only(right: 2),
                child: Icon(
                  Icons.notifications_rounded,
                  color: Appcolor.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(160),
                    image: DecorationImage(
                        image: NetworkImage(
                          img,
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "hello, ${name}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Appcolor.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}
