import 'package:flutter/material.dart';
import 'package:sire/controller/setting/settingcontroller.dart';
import 'package:sire/core/constant/color.dart';

class NotificationTile extends StatelessWidget {
  final SettingControllerImp controller;

  const NotificationTile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        value: controller.isNotificationEnabled ?? false,
        onChanged: (value) => controller.disableNotification(),
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          "Receive updates and alerts",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        secondary: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Appcolor.deepPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: Appcolor.deepPurple,
            size: 20,
          ),
        ),
        activeColor: Appcolor.deepPurple,
      ),
    );
  }
}