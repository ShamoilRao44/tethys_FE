// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class MaterialRequestView extends StatelessWidget {
  const MaterialRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: AppText(
                      text: 'Material Requests',
                      textAlign: TextAlign.center,
                      size: 32,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 480,
                  child: Table(
                    border: TableBorder.all(
                      color: AppColors.bordercolor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: 'Items',
                              textAlign: TextAlign.center,
                              size: 16,
                              color: AppColors.txtColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: 'Qty \nRequested',
                              textAlign: TextAlign.center,
                              size: 15,
                              color: AppColors.txtColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: 'Qty \n Issued',
                              textAlign: TextAlign.center,
                              size: 15,
                              color: AppColors.txtColor,
                            ),
                          )
                        ],
                      ),
                      ...c.tableRows,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
