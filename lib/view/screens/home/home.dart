import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sire/apilink.dart';
import 'package:sire/controller/home/homeController.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/home/categorieslist.dart';
import 'package:sire/view/widgets/home/discountcard.dart';
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
                        name: controller.username!, img: controller.pfp),
                    discountcard: controller.statusRequest ==
                            StatusRequest.loding
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          )
                        : Discountcard(
                            title: controller.mainPage[0]['mainpage_title'],
                            content: controller.mainPage[0]['mainpage_body'],
                            image: CachedNetworkImageProvider(
                              AppLink.homeimage +
                                  controller.mainPage[0]['mainpage_image'],
                            )),
                    serchBar: SerchBar(
                        controller: controller.textEditingController,
                        onPressed: () async {
                          controller.goToSearch();
                        },
                        hint: "Search Product"),
                    categorieslist: Categorieslist(),
                  ),
                  ItemsList()
                ],
              );
            },
          )),
    );
  }
}
