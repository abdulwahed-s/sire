import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const InfoRow(
      {super.key, required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Appcolor.amaranthpink.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Appcolor.amaranthpink,
            size: 18,
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 2),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
