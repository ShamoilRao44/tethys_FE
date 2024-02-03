// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/archive/archive_vm.dart';
import 'package:tethys/resources/app_colors.dart';

class ArchiveView extends StatelessWidget {
  const ArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchiveVM>(
      builder: (c) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.bgGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      },
    );
  }
}
