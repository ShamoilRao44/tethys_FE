// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (c.itemNameCtrl.text.isNotEmpty &&
                              c.itemQtyCtrl.text.isNotEmpty) {
                            c.addRow();
                          }
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
                                Autocomplete<String>(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return c.itemNameList;
                                    }
                                    return c.itemNameList.where(
                                      (String option) {
                                        return option.contains(
                                          textEditingValue.text.toLowerCase(),
                                        );
                                      },
                                    );
                                  },
                                  onSelected: (option) {
                                    c.itemNameCtrl.text = option;
                                  },
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
                          onPressed: () {
                            c.itemNameCtrl.clear();
                            c.itemQtyCtrl.clear();
                            c.tableRows.clear();
                            c.sendRequest(ctx);
                            Get.back();
                          },
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: AppText(
                    text: 'Your Requests',
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
            SizedBox(height: 24),
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
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Item',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Qty \nRequested'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Qty \napproved'),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            newRequestDialog(context);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
