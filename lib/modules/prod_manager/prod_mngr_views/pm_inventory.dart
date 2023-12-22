// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class PmInventory extends StatelessWidget {
  const PmInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          text: 'Production Manager Inventory',
                          textAlign: TextAlign.center,
                          size: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.interBold,
                          color: AppColors.txtColor,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'logout',
                                child: AppText(
                                  text: 'Logout',
                                  color: AppColors.txtColor,
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == 'logout') {
                              logout();
                            }
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.txtColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 800.h,
                      child: SingleChildScrollView(
                        child: Table(
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          border: TableBorder.all(
                            width: 1.0,
                            color: AppColors.darkblue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(4),
                            3: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sr. No.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Item Id',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Item Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Available Qty',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.txtColor,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...c.invntryTableRows,
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
