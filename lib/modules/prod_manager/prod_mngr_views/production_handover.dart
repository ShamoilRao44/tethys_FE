// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'package:tethys/utils/widgets/app_text_form_fied.dart';

class ProductionHandover extends StatelessWidget {
  const ProductionHandover({super.key});

  void createHandoverDialog(BuildContext context) {
    Get.dialog(
      GetBuilder<ProdMngrVM>(builder: (c) {
        return AlertDialog(
          title: AppText(
            text: 'Handover',
            textAlign: TextAlign.center,
            size: 24,
            fontWeight: FontWeight.w700,
            fontFamily: AppFonts.interBold,
            color: AppColors.txtColor,
          ),
          backgroundColor: AppColors.white,
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxHeight: 800.h),
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextFormField(
                      labelText: 'Title',
                      controller: c.handoverTitleCtrl,
                    ),
                    SizedBox(height: 8),
                    c.tableRows.isNotEmpty
                        ? Table(
                            border: TableBorder.all(
                              width: 1.0,
                              color: AppColors.bordeColor2,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            columnWidths: {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Item Name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppFonts.interRegular,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Qty',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: AppFonts.interRegular,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ...c.tableRows,
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Item Name',
                              focusColor: Colors.transparent,
                            ),
                            controller: c.itemNameCtrl,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                hintText: 'Qty',
                                focusColor: Colors.transparent,
                              ),
                              controller: c.itemQtyCtrl,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              c.addRowForHandover();
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                c.itemNameCtrl.clear();
                c.itemNameCtrl.clear();
                c.tableRows.clear();
                c.sendApiList.clear();
                c.update();
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                c.sendHandover(context);
              },
              child: Text('Submit'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(
      builder: (c) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          text: 'Production Handover',
                          textAlign: TextAlign.center,
                          size: 32.sp,
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
                            size: 32.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.txtColor,
              onPressed: () {
                c.tableRows.clear();
                c.sendApiList.clear();
                createHandoverDialog(context);
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        );
      },
    );
  }
}
