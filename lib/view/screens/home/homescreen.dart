import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/home/homescreenController.dart';
import 'package:sire/view/screens/cart/cart.dart';
import 'package:sire/view/widgets/home/custombottomnavigationbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {
              Get.to(
                () => Cart(),
                transition: Transition.fade,
                duration: Duration(seconds: 1),
              );
            },
            child: const Icon(Icons.shopping_basket_outlined),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CustomBottomNavigationBar(),
          extendBody: true,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: controller.listpages.elementAt(controller.currentpage),
          ),
        );
      },
    );
  }
}
