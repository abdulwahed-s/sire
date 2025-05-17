import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/controller/delivery/deliveryhomecontroller.dart';
import 'package:sire/core/constant/color.dart';

class DeliveryBottomNavigationBar extends StatelessWidget {
  const DeliveryBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryHomeControllerImp>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomAppBar(
            height: 70,
            notchMargin: 8,
            elevation: 0,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.listpages.length,
                (index) => _buildNavItem(
                  context,
                  icon: controller.iconpages[index],
                  label: controller.namepages[index],
                  isActive: controller.currentpage == index,
                  onTap: () => controller.changePage(index),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: Appcolor.berry.withValues(alpha: 0.2),
          highlightColor: Appcolor.berry.withValues(alpha: 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 24,
                color: isActive ? Appcolor.berry : Colors.grey[600],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? Appcolor.berry : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
