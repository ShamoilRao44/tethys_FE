// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_button.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class RequestMaterialView extends StatelessWidget {
  const RequestMaterialView({super.key});

  void newRequestDialog(BuildContext ctx) {
    Get.dialog(
      AlertDialog(
        title: AppText(
          text: 'Request material',
          textAlign: TextAlign.center,
          size: 24,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.interBold,
          color: AppColors.txtColor,
        ),
        backgroundColor: AppColors.white,
        content: GetBuilder<ProdMngrVM>(
          builder: (c) {
            return Container(
              width: 400.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        c.addRow();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 16,
                          ),
                          AppText(
                            text: 'Add Item',
                            size: 16,
                            fontFamily: AppFonts.interRegular,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 560.h,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Table(
                        border: TableBorder.all(
                          color: AppColors.bordercolor,
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
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    focusColor: Colors.transparent,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  controller: c.itemNameCtrl,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    focusColor: Colors.transparent,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  controller: c.itemQtyCtrl,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          c.itemNameCtrl.clear();
                          c.itemQtyCtrl.clear();
                          c.tableRows.clear();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: AppText(
                          text: 'Cancel',
                          size: 16,
                          fontFamily: AppFonts.interRegular,
                          color: AppColors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: AppText(
                          text: 'Submit',
                          size: 16,
                          fontFamily: AppFonts.interRegular,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: AppText(
                  text: 'Your Requests',
                  size: 32,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFonts.interBold,
                  color: AppColors.txtColor,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                newRequestDialog(context);
              },
              backgroundColor: AppColors.btnColor,
              shape: CircleBorder(),
              child: Icon(
                Icons.add,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
