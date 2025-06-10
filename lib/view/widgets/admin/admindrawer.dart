import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/adminhomecontroller.dart';
import 'package:sire/view/widgets/admin/admindrawerfooterwidget.dart';
import 'package:sire/view/widgets/admin/admindrawerheaderwidget.dart';
import 'package:sire/view/widgets/admin/admindrawermenuitemswidget.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminHomeControllerImp>(
      builder: (controller) => Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            // Custom Header Section
            AdminDrawerHeaderWidget(controller: controller),

            // Menu Items
            Expanded(
              child: AdminDrawerMenuItemsWidget(controller: controller),
            ),

            // Bottom Section
            AdminDrawerFooterWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
