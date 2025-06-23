import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/admindashboardcontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/view/widgets/admin/graphscontent.dart';
import 'package:sire/view/widgets/admin/loadingstate.dart';

class AdminGraph extends StatelessWidget {
  const AdminGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) {
        return controller.statusRequest == StatusRequest.loding
            ? LoadingState()
            : GraphsContent(controller: controller);
      },
    );
  }
}








