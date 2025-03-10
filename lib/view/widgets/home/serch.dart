import 'package:flutter/material.dart';
import 'package:sire/core/constant/color.dart';

class SerchBar extends StatelessWidget {
  final void Function()? onPressed;
  final String hint;
  const SerchBar({super.key, this.onPressed, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: InkWell(onTap: onPressed, child: Icon(Icons.search)),
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          fillColor: Appcolor.white,
          filled: true,
        ),
      ),
    );
  }
}
