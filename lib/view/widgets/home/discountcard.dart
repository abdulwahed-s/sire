import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class Discountcard extends StatelessWidget {
  final String title;
  final String content;
  final ImageProvider<Object> image;
  const Discountcard({
    super.key,
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolor.shadow,
                      blurRadius: 10,
                      offset: Offset(0.1, 0.1),
                    )
                  ],
                  color: Appcolor.grey,
                  borderRadius: BorderRadius.circular(30)),
              height: 180,
              child: ListTile(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Appcolor.white),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
                subtitle: Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Appcolor.white),
                ),
              )),
        ],
      ),
    );
  }
}
