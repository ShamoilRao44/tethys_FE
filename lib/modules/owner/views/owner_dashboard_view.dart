// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/owner_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/utils/common.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OwnerHomeVM>(
      builder: (c) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
              image: AssetImage(AppImages.bgImage),
              opacity: 0.5,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [headerRow(headerText: 'Dashboard', onRefresh: c.onInit)],
          ),
        );
      },
    );
  }
}
