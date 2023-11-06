// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class RequisitionReturnView extends StatelessWidget {
  const RequisitionReturnView({super.key});

  void newRequestDialog(BuildContext ctx) {
    Get.dialog(
      AlertDialog(
        title: AppText(
          text: 'Requisition/Return',
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
              constraints: BoxConstraints(maxHeight: 800.h),
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
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                      ),
                      value: c.selectedOption,
                      items: ['Request Material', 'Return Material'].map(
                        (item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        c.selectedOption = value!;
                      },
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: c.remarkCtrl,
                      decoration: InputDecoration(
                        hintText: 'Add Remark',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.bordeColor2),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Table(
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
                            TableRow(
                              children: [
                                Autocomplete<String>(
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode,
                                      onFieldSubmitted) {
                                    return TextField(
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                          hintText: 'Item Name'),
                                    );
                                  },
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
                            c.remarkCtrl.clear();
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
                            if (c.selectedOption == 'Request Material') {
                              c.sendRequest(ctx);
                            } else {
                              c.returnMaterial(ctx);
                            }
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
    return GetBuilder<ProdMngrVM>(builder: (c) {
      return Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
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
                  child: Container(
                    height: 728.h,
                    child: ListView.builder(
                      itemCount: c.pendingRequisitionsList.length,
                      itemBuilder: (context, index) {
                        List<TableRow> tableRowsHere = c.requestTableMaker(
                            c.pendingRequisitionsList[index].requisitions!);
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
                                color: AppColors
                                    .lightBlue, // Change color when expanded
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppText(
                                    text: c.pendingRequisitionsList[index]
                                            .remarks ??
                                        'Remark',
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
                                        text:
                                            'Slot Id : ${c.pendingRequisitionsList[index].slotId}'
                                                .toString(),
                                        color: AppColors.txtColor,
                                        size: 16,
                                        fontFamily: AppFonts.interRegular,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SizedBox(width: 32),
                                      AppText(
                                        text:
                                            "Date : ${c.pendingRequisitionsList[index].reqTime.toString().substring(0, 9)}",
                                        color: AppColors.txtColor,
                                        size: 16,
                                        fontFamily: AppFonts.interRegular,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ],
                                  ),
                                  c.isExpanded[index]
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Table(
                                                  border: TableBorder.all(
                                                    width: 1.0,
                                                    color: AppColors.darkblue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Item Name',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .txtColor,
                                                              fontFamily: AppFonts
                                                                  .interRegular,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Qty',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .txtColor,
                                                              fontFamily: AppFonts
                                                                  .interRegular,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    ...tableRowsHere,
                                                  ],
                                                ),
                                              ],
                                            ),
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.txtColor,
            onPressed: () {
              newRequestDialog(context);
            },
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    });
  }
}
