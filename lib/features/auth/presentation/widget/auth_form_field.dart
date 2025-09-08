import 'package:clean_architucture/core/extension/string_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.keyboardType,
    this.isObscureText = false,
    super.key,
  });

  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText.titleCase,
        hintStyle: TextStyle(
          fontSize: 16,
          color: const Color(0xffE8F3F4).withValues(alpha: .4),
        ),
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.whiteColor),
        ),
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
