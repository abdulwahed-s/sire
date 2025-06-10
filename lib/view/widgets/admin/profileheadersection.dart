import 'package:flutter/material.dart';
import 'package:sire/controller/admin/settings/updateaccountinformationcontroller.dart';
import 'package:sire/view/widgets/admin/bannerimagewidget.dart';
import 'package:sire/view/widgets/admin/profilepicturewidget.dart';

class ProfileHeaderSection extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const ProfileHeaderSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Banner Image Section
          BannerImageWidget(controller: controller),
          const SizedBox(height: 20),
          // Profile Picture Section
          ProfilePictureWidget(controller: controller),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}