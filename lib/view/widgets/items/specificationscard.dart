import 'package:flutter/material.dart';
import 'package:sire/controller/items/itemsdetailsController.dart';
import 'package:sire/view/widgets/items/specrow.dart';

class SpecificationsCard extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const SpecificationsCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Information",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 16),
              SpecRow(
                label: "Category",
                value: controller.data.categoryName ?? "General",
              ),
              SpecRow(
                label: "Availability",
                value: controller.data.itemCount! > 0
                    ? "In Stock"
                    : "Out of Stock",
              ),
              if (controller.data.itemDiscount! > 0)
                SpecRow(
                  label: "Discount",
                  value: "${controller.data.itemDiscount}%",
                ),
            ],
          ),
        ),
        if (controller.allRating.isEmpty) const SizedBox(height: 50),
      ],
    );
  }
}
