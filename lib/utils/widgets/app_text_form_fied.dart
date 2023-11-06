// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tethys/resources/app_colors.dart';

class AppTextFormField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? obscureText;
  const AppTextFormField({
    this.labelText,
    this.controller,
    this.obscureText,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: keyboardType ?? TextInputType.name,
      decoration: InputDecoration(
        label: Text(
          labelText ?? 'label',
          style: TextStyle(fontSize: 16),
        ),
        filled: true,
        fillColor: AppColors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.bordeColor2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.bordeColor2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (value) => controller!.text = value,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter this field';
        } else {
          return null;
        }
      },
    );
  }
}
