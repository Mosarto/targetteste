import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final Icon icon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  const CustomTextFieldWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.focusNode,
    required this.controller,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        TextFormField(
          obscureText: obscureText!,
          focusNode: focusNode,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: icon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
