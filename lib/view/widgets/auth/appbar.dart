import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/constant/imageasset.dart';

class AUTHAppbar<T extends GetxController> extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final T controller;
  final StatusRequest Function(T controller) statusRequest; 

  const AUTHAppbar({
    super.key,
    required this.text,
    required this.controller,
    required this.statusRequest,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: controller,
      builder: (ctrl) {
        final currentStatus = statusRequest(ctrl); 
        return AppBar(
          backgroundColor: currentStatus == StatusRequest.loding
              ? const Color.fromARGB(186, 0, 0, 0)
              : Appcolor.white,
          centerTitle: true,
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: currentStatus == StatusRequest.loding
                    ? Appcolor.mimiPink
                    : Appcolor.deepcyan),
          ),
          actions: [
            Image.asset(
              AppImage.authLogo,
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
