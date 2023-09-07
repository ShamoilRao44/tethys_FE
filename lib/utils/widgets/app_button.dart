// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/resources/app_colors.dart';

class AppButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final double? textsize;
  final String? text;
  final double? btnWidth;
  final double? btnHeigth;
  final OutlinedBorder? shape;
  final VoidCallback onPressed;

  const AppButton({
    Key? key,
    this.icon,
    this.iconColor,
    this.textColor,
    this.textsize,
    this.text,
    this.btnWidth,
    this.btnHeigth,
    this.shape,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.bgColor),
              borderRadius: BorderRadius.circular(16)),
          child: icon != null
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: iconColor ?? AppColors.black,
                    size: 24.h,
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: textsize ?? 12.h,
                      color: textColor ?? AppColors.white,
                    ),
                  ),
                ),
        ));
  }
}
