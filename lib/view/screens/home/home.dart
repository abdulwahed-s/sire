import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/home/categorieslist.dart';
import 'package:sire/view/widgets/home/discountcard.dart';
import 'package:sire/view/widgets/home/divider.dart';
import 'package:sire/view/widgets/home/greeting.dart';
import 'package:sire/view/widgets/home/itemslist.dart';
import 'package:sire/view/widgets/home/serch.dart';
import 'package:sire/view/widgets/home/upview.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Appcolor.black),
      child: Scaffold(
          backgroundColor: Appcolor.white,
          body: GetBuilder<HomeControllerImp>(
            builder: (controller) {
              return ListView(
                children: [
                  UpperView(
                    greeting: Greeting(
                      name: controller.username!,
                      img:
                          "https://i.pinimg.com/736x/ac/76/4c/ac764cb8541c8d73e039fba4c3d4df40.jpg",
                    ),
                    discountcard: Discountcard(
                        title: "Uncover exciting products at fantastic prices!",
                        content: "50% discount"),
                    serchBar: SerchBar(
                        controller: controller.textEditingController,
                        onPressed: () async {
                          controller.goToSearch();
                        },
                        hint: "Search Product"),
                    categorieslist: Categorieslist(),
                  ),
                  HomeDivider(leftText: "Products Promo", rightText: "See All"),
                  SizedBox(
                    height: 10,
                  ),
                  ItemsList()
                ],
              );
            },
          )),
    );
  }
}
