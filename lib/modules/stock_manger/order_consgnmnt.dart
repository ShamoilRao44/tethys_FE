// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text_form_fied.dart';

import '../../resources/app_colors.dart';
import '../../utils/widgets/app_text.dart';

class OrderConsgnmnt extends StatelessWidget {
  const OrderConsgnmnt({super.key});

  void newOrderDialog(BuildContext ctx) {
    Get.dialog(
      GetBuilder<StockMngrVM>(builder: (c) {
        return AlertDialog(
          title: AppText(
            text: 'New Order',
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
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8),
                    AppTextFormField(
                      labelText: 'Supplier Name',
                      controller: c.suppNameCtrl,
                    ),
                    SizedBox(height: 8),
                    AppTextFormField(
                      labelText: 'Invoice No.',
                      controller: c.invoiceCtrl,
                    ),
                    SizedBox(height: 8),
                    AppTextFormField(
                      labelText: 'Vehicle No.',
                      controller: c.vehicleCtrl,
                    ),
                    SizedBox(height: 8),
                    AppTextFormField(
                      labelText: 'Total Amount',
                      controller: c.totalAmtCtrl,
                    ),
                    SizedBox(height: 8),
                    AppTextFormField(
                      labelText: 'Remarks',
                      controller: c.remarksCtrl,
                    ),
                    SizedBox(height: 16),
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
                          child: Autocomplete<String>(
                            fieldViewBuilder: (context, textEditingController,
                                focusNode, onFieldSubmitted) {
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration:
                                    InputDecoration(hintText: 'Item Name'),
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
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                              c.addRow();
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
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                c.sendOrder(ctx);
              },
              child: Text('Submit'),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      }),
      barrierDismissible: false,
    );
  }

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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.txtColor,
            onPressed: () {
              newOrderDialog(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      );
    });
  }
}
