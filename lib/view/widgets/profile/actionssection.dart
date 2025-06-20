import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:sire/controller/profile/profilecontroller.dart';
import 'package:sire/view/widgets/profile/actiontile.dart';

class ActionsSection extends StatelessWidget {
  final ProfileControllerImp controller;

  const ActionsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ActionTile(
            icon: Iconsax.car,
            title: 'Pending Orders',
            subtitle: 'Track your current orders',
            onTap: () => controller.goToUnDeliverdOrders(),
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          ActionTile(
            icon: Iconsax.archive,
            title: 'Order History',
            subtitle: 'View your past orders',
            onTap: () => controller.goToArchivedOrder(),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}