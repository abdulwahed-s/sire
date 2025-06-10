import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/admin/settings/createnewdeliveryaccountcontroller.dart';
import 'package:sire/view/widgets/admin/DeliveryCreateAccountButtonWidget.dart';
import 'package:sire/view/widgets/admin/DeliveryFormSectionWidget.dart';
import 'package:sire/view/widgets/admin/DeliveryHeaderSectionWidget.dart';

class CreateNewDeliveryAccount extends StatelessWidget {
  const CreateNewDeliveryAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateNewDeliveryAccountControllerImp());
    return GetBuilder<CreateNewDeliveryAccountControllerImp>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text(
            'Create Delivery Account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const DeliveryHeaderSectionWidget(),

              const SizedBox(height: 30),

              // Form Section
              DeliveryFormSectionWidget(),

              const SizedBox(height: 30),

              // Create Account Button
              DeliveryCreateAccountButtonWidget(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
