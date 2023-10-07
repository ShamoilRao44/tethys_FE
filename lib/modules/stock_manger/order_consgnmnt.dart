// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';

import '../../resources/app_colors.dart';
import '../../utils/widgets/app_text.dart';

class OrderConsgnmnt extends StatelessWidget {
  const OrderConsgnmnt({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: AppText(
                  text: 'Orders and Consignment',
                  textAlign: TextAlign.center,
                  size: 24,
                  color: AppColors.txtColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.interBold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
