import 'package:flutter/material.dart';

class BuildInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final int maxLines;
  const BuildInfoRow({super.key, required this.icon, required this.text,required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 15),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
