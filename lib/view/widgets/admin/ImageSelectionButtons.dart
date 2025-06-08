import 'package:flutter/material.dart';
import 'package:sire/controller/admin/offermessage/editoffercontroller.dart';
import 'package:sire/view/widgets/admin/ImageButton.dart';

class ImageSelectionButtons extends StatelessWidget {
  final EditOfferControllerImp controller;

  const ImageSelectionButtons({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ImageButton(
            icon: Icons.camera_alt,
            label: 'Camera',
            onTap: () => controller.getImageByCamera(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ImageButton(
            icon: Icons.photo_library,
            label: 'Gallery',
            onTap: () => controller.getImageByGallery(),
          ),
        ),
      ],
    );
  }
}

