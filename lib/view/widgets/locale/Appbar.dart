import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/view/widgets/locale/List.dart';

class LCAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("1".tr),
      actions: [
        IconButton(
            tooltip: "2".tr,
            onPressed: () {
              Get.defaultDialog(
                  actions: lcList(),
                  title: "2".tr,
                  content: SizedBox(
                    height: 0,
                    width: 0,
                  ));
            },
            icon: Icon(
              Icons.language,
            ))
      ],
    );
    
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
