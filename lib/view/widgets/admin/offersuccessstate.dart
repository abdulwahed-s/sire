import 'package:flutter/material.dart';
import 'package:sire/controller/admin/offermessage/offercontroller.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/widgets/admin/infosection.dart';
import 'package:sire/view/widgets/admin/offercard.dart';
import 'package:sire/view/widgets/admin/offersectionheader.dart';

class OfferSuccessState extends StatelessWidget {
  final OfferControllerImp controller;
  const OfferSuccessState({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.getOfferMessage(),
      color: Appcolor.berry,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OfferSectionHeader(
              title: 'Current Offer',
              isLoading: false,
            ),
            const SizedBox(height: 16),
            OfferCard(controller: controller),
            const SizedBox(height: 32),
            InfoSection(
              isLoading: false,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
