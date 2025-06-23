import 'package:flutter/material.dart';

class AUTHForm extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final String? Function(String?)? validator;
  final String type;
  final bool? obscureText;
  final void Function()? onTap;
  final TextEditingController controller;
  const AUTHForm(
      {super.key,
      required this.label,
      required this.icon,
      required this.hint,
      required this.controller,
      required this.validator,
      required this.type,
      this.obscureText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: type == "phone"
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        obscureText: obscureText == null || obscureText == false ? false : true,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            label: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            suffixIcon: InkWell(
                splashColor: Colors.transparent,
                onTap: onTap,
                child: Icon(icon))),
      ),
    );
  }
}
