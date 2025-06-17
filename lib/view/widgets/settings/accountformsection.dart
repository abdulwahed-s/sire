import 'package:flutter/material.dart';
import 'package:sire/controller/setting/updateaccountinformationcontroller.dart';
import 'package:sire/view/widgets/admin/accounttextfield.dart';

class AccountFormSection extends StatelessWidget {
  final UpdateAccountInformationControllerImp controller;

  const AccountFormSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: controller.globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            AccountTextField(
              controller: controller.username!,
              label: 'Username',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            AccountTextField(
              controller: controller.email!,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AccountTextField(
              controller: controller.phoneNumber!,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            AccountTextField(
              controller: controller.password!,
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 8),
            Text(
              'Leave blank if you don\'t want to change password',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
