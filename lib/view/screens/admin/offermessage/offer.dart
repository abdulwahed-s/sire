import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/offermessage/offercontroller.dart';
import 'package:sire/core/class/statusrequest.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/offerloadingstate.dart';
import 'package:sire/view/widgets/admin/offersuccessstate.dart';

class Offer extends StatelessWidget {
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OfferControllerImp());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        floatingActionButton: GetBuilder<OfferControllerImp>(
          builder: (controller) => FloatingActionButton.extended(
            onPressed: controller.statusRequest == StatusRequest.loding
                ? null
                : () => controller.goToEditMessage(),
            backgroundColor: controller.statusRequest == StatusRequest.loding
                ? Colors.grey[400]
                : Appcolor.berry,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.edit_rounded),
            label: const Text('Edit Offer'),
            tooltip: "Edit Offer Message",
          ),
        ),
        body: GetBuilder<OfferControllerImp>(builder: (controller) {
          switch (controller.statusRequest) {
            case StatusRequest.loding:
              return const OfferLoadingState();
            case StatusRequest.success:
              return OfferSuccessState(controller: controller);
            default:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
