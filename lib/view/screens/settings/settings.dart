import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sire/controller/setting/settingcontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/SectionHeader.dart';
import 'package:sire/view/widgets/settings/contactdialog.dart';
import 'package:sire/view/widgets/settings/logoutbutton.dart';
import 'package:sire/view/widgets/settings/notificationtile.dart';
import 'package:sire/view/widgets/settings/settingstile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingControllerImp controller = Get.put(SettingControllerImp());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolor.white,
        body: CustomScrollView(
          slivers: [
            // App Bar
            const SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: Appcolor.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Appcolor.berry,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                centerTitle: true,
              ),
            ),

            // Settings Content
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(245, 245, 245, 245),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Preferences Section
                      const SectionHeader(title: 'Preferences'),
                      const SizedBox(height: 15),

                      // Notification Toggle
                      GetBuilder<SettingControllerImp>(
                        builder: (controller) =>
                            NotificationTile(controller: controller),
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Languages",
                        icon: Icons.language,
                        iconColor: Appcolor.indigoBlue,
                        onTap: () => controller.changeLanguages(),
                      ),

                      const SizedBox(height: 25),

                      // Account Section
                      const SectionHeader(title: 'Account'),
                      const SizedBox(height: 15),

                      SettingsTile(
                        title: "Your Ratings",
                        icon: Iconsax.heart,
                        iconColor: Appcolor.deepRed,
                        onTap: () => controller.goToAllRating(),
                      ),

                      const SizedBox(height: 10),

                      if (!controller.isApprove!) ...[
                        SettingsTile(
                          title: "Verify Your Account",
                          subtitle:
                              "Complete verification to unlock all features",
                          icon: Icons.verified,
                          iconColor: Appcolor.lightRed,
                          showBadge: true,
                          onTap: () => controller.goToVerify(),
                        ),
                        const SizedBox(height: 10),
                      ],

                      SettingsTile(
                        title: "Address",
                        icon: Icons.location_on_rounded,
                        iconColor: Appcolor.amaranthpink,
                        onTap: () => controller.goToAddress(),
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Edit Account Information",
                        icon: Icons.edit,
                        iconColor: Appcolor.teal,
                        onTap: () => controller.goToUpdateAccountInformation(),
                      ),

                      const SizedBox(height: 25),

                      // Support Section
                      const SectionHeader(title: 'Support'),
                      const SizedBox(height: 15),

                      SettingsTile(
                        title: "About Us",
                        icon: Icons.info_outline,
                        iconColor: Appcolor.berry,
                        onTap: () {},
                      ),

                      const SizedBox(height: 10),
                      SettingsTile(
                        title: "Contact Us",
                        subtitle: "Get help and support",
                        icon: Icons.phone_rounded,
                        iconColor: Appcolor.indigoBlue,
                        onTap: () => ContactDialog.show(controller),
                      ),

                      const SizedBox(height: 25),

                      // Logout Button
                      LogoutButton(controller: controller),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
