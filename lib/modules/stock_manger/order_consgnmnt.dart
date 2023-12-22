// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
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
                            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                              return TextField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: InputDecoration(hintText: 'Item Name'),
                              );
                            },
                            optionsBuilder: (TextEditingValue textEditingValue) {
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
                c.sendApiList.clear();
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
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      }),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
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
                          text: 'Orders & Consignment',
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
                  SingleChildScrollView(
                    child: Container(
                      height: 736.h,
                      child: ListView.builder(
                        itemCount: c.ordersList.length,
                        itemBuilder: (context, index) {
                          List<TableRow> tableRowsHere = c.ordersTableMaker(c.ordersList[index].orders!);
                          return Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  c.toggleExpansionForOrders(index);
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  height: c.isExpandedForOrders[index] ? 400 : 96,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: c.isExpandedForOrders[index] ? AppColors.lightBlue : AppColors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: c.ordersList[index].remarks ?? 'Remarks',
                                          color: const Color.fromRGBO(62, 86, 126, 1),
                                          size: MediaQuery.of(context).size.width > 300 ? 20 : 20.h,
                                          fontFamily: AppFonts.interRegular,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AppText(
                                              text: 'Name: ${c.ordersList[index].purBy!.name ?? ''}',
                                              color: AppColors.txtColor,
                                              size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                              fontFamily: AppFonts.interRegular,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 2,
                                            ),
                                            SizedBox(width: 32.w),
                                            AppText(
                                              text: 'Date: ${c.ordersList[index].purTime.toString().substring(0, 10)}',
                                              color: AppColors.txtColor,
                                              size: MediaQuery.of(context).size.width > 400 ? 16 : 16.w,
                                              fontFamily: AppFonts.interRegular,
                                              fontWeight: FontWeight.w400,
                                            )
                                          ],
                                        ),
                                        c.isExpandedForOrders[index]
                                            ? SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text: 'Invoice: ${c.ordersList[index].invoice ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    AppText(
                                                      text: 'Vehicle No.: ${c.ordersList[index].vehicle ?? ''}',
                                                      color: AppColors.txtColor,
                                                      size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                      fontFamily: AppFonts.interRegular,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    SizedBox(height: 8),
                                                    Table(
                                                      border: TableBorder.all(
                                                        width: 1.0,
                                                        color: AppColors.darkblue,
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
                                                                  color: AppColors.txtColor,
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
                                                                  color: AppColors.txtColor,
                                                                  fontFamily: AppFonts.interRegular,
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w600,
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
                                              )
                                            : Container(),
                                      ]),
                                ),
                              ));
                        },
                      ),
                    ),
                  )
                ],
              ),
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
        ),
      );
    });
  }
}
