// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                child: Container(
                  height: 728.h,
                  child: ListView.builder(
                    itemCount: c.materialReqList.length,
                    itemBuilder: (context, index) {
                      List<TableRow> tableRowsHere = c.requestTableMaker(
                          c.materialReqList[index].requisitions!);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            c.toggleExpansion(index);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: c.isExpanded[index] ? 400 : 96,
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: c.isExpanded[index]
                                  ? AppColors.lightBlue
                                  : AppColors.lightBlue,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppText(
                                  text: c.materialReqList[index].remarks ??
                                      'Remarks',
                                  color: AppColors.txtColor,
                                  size: 20,
                                  fontFamily: AppFonts.interRegular,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(
                                      text: c.materialReqList[index].reqBy!
                                              .name ??
                                          '',
                                      color: AppColors.txtColor,
                                      size: 16,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    SizedBox(width: 32),
                                    AppText(
                                      text:
                                          'Date: ${c.materialReqList[index].reqTime.toString().substring(0, 10)}',
                                      color: AppColors.txtColor,
                                      size: 16,
                                      fontFamily: AppFonts.interRegular,
                                      fontWeight: FontWeight.w400,
                                    )
                                  ],
                                ),
                                c.isExpanded[index]
                                    ? Container(
                                        child: Table(
                                          border: TableBorder.all(
                                            width: 1.0,
                                            color: AppColors.bordeColor2,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          columnWidths: {
                                            0: FlexColumnWidth(3),
                                            1: FlexColumnWidth(1),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Item Name',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.interRegular,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Qty',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppFonts.interRegular,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            ...tableRowsHere,
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
