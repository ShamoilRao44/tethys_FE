// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ProdMngrDashboard extends StatelessWidget {
  const ProdMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: AppText(
                text: 'Production Manager',
                textAlign: TextAlign.center,
                size: 32,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.interBold,
                color: AppColors.txtColor,
              ),
            ),
            Expanded(
              child: Center(
                child: AppText(
                  text: 'Nothing to show here',
                  size: 32,
                  color: AppColors.txtColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.interBold,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
