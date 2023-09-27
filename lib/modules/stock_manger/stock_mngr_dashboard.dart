import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';

import '../../resources/app_colors.dart';
import '../../utils/widgets/app_text.dart';

class StockMngrDashboard extends StatelessWidget {
  const StockMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: AppText(
                text: 'Nothing to show here',
                size: 32,
                color: AppColors.fluoroscentBlue,
                fontWeight: FontWeight.w700,
                fontFamily: AppFonts.interBold,
              ),
            )
          ],
        ),
      );
    });
  }
}


