import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/view/screens/search/search.dart';

class SerchBar extends StatelessWidget {
  final void Function()? onPressed;
  final String hint;
  final TextEditingController? controller;
  const SerchBar(
      {super.key,
      this.onPressed,
      required this.hint,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: (value) {
          Get.to(const Search(),
              transition: Transition.cupertinoDialog,
              arguments: {"input": value});
        },
        decoration: InputDecoration(
          prefixIcon: InkWell(onTap: onPressed, child: const Icon(Icons.search)),
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
