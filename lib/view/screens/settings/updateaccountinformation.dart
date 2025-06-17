import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/setting/updateaccountinformationcontroller.dart';
import 'package:sire/view/widgets/settings/accountformsection.dart';
import 'package:sire/view/widgets/settings/profileheadersection.dart';
import 'package:sire/view/widgets/settings/savechangesbutton.dart';
import 'package:sire/view/widgets/admin/updateaccountappbar.dart';

class UpdateAccountInformation extends StatelessWidget {
  const UpdateAccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateAccountInformationControllerImp());
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const UpdateAccountAppBar(),
      body: GetBuilder<UpdateAccountInformationControllerImp>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header Section
              ProfileHeaderSection(controller: controller),

              const SizedBox(height: 20),

              // Form Section
              AccountFormSection(controller: controller),

              const SizedBox(height: 30),

              // Save Button
              SaveChangesButton(controller: controller),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
