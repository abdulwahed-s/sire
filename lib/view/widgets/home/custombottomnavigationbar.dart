import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homescreenController.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/home/bottombarbutton.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return BottomAppBar(
          height: 70,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: Appcolor.amaranthpink,
          child: Row(
            children: [
              ...List.generate(
                controller.listpages.length + 1,
                (index) {
                  int m = index > 2 ? index - 1 : index;
                  return index == 2
                      ? const Spacer()
                      : BottomBarButton(
                          isActive:
                              controller.currentpage == (m) ? true : false,
                          onPressed: () => controller.changePage(m),
                          iconData: controller.iconpages[m],
                          text: controller.namepages[m],
                        );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
