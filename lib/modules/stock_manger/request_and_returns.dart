// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          text: 'Requests & Returns',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          c.toggleViews(true);
                        },
                        child: Text('Requests'),
                        style: ElevatedButton.styleFrom(
                          elevation: c.isRequests ? 0 : 2,
                          backgroundColor:
                              c.isRequests ? Colors.amber.shade700.withOpacity(0.6) : Colors.amber.shade400,
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          c.toggleViews(false);
                        },
                        child: Text('Returns'),
                        style: ElevatedButton.styleFrom(
                            elevation: c.isRequests ? 2 : 0,
                            backgroundColor:
                                c.isRequests ? Colors.amber.shade400 : Colors.amber.shade700.withOpacity(0.6)),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  c.isRequests
                      ? SingleChildScrollView(
                          //request view
                          child: Container(
                            height: 736.h,
                            child: ListView.builder(
                              itemCount: c.materialReqList.length,
                              itemBuilder: (context, index) {
                                List<TableRow> tableRowsHere =
                                    c.requestTableMaker(c.materialReqList[index].requisitions!);
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      c.toggleExpansion(index);
                                    },
                                    child: Slidable(
                                      enabled: c.isExpanded[index] ? false : true,
                                      endActionPane: ActionPane(
                                        extentRatio: 0.3,
                                        motion: StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (ctx) {
                                              c.denyRequest(slotId: c.materialReqList[index].slotId!, context: context);
                                            },
                                            icon: Icons.delete,
                                            backgroundColor: AppColors.errorColor,
                                            borderRadius: BorderRadius.circular(10),
                                            spacing: 0,
                                            padding: EdgeInsets.zero,
                                          )
                                        ],
                                      ),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        height: c.isExpanded[index] ? 400 : 96,
                                        padding: EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: c.isExpanded[index] ? AppColors.lightBlue : AppColors.lightBlue,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    AppText(
                                                      text: c.materialReqList[index].remarks ?? 'Remarks',
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
                                                          text: c.materialReqList[index].reqBy!.name ?? '',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        SizedBox(width: 32.w),
                                                        AppText(
                                                          text:
                                                              'Date: ${c.materialReqList[index].reqTime.toString().substring(0, 10)}',
                                                          color: AppColors.txtColor,
                                                          size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                          fontFamily: AppFonts.interRegular,
                                                          fontWeight: FontWeight.w400,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.approveRequest(
                                                      slotId: c.materialReqList[index].slotId!,
                                                      context: context,
                                                    );
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.all(16),
                                                      elevation: 0,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      backgroundColor: AppColors.btnColor),
                                                  child: Icon(Icons.check),
                                                ),
                                              ],
                                            ),
                                            c.isExpanded[index]
                                                ? Container(
                                                    height: 300,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 16),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
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
                                                            // ElevatedButton(
                                                            //   onPressed: () {},
                                                            //   style: ElevatedButton.styleFrom(
                                                            //     backgroundColor: AppColors.errorColor,
                                                            //   ),
                                                            //   child: AppText(
                                                            //     text: 'Deny',
                                                            //     color: AppColors.white,
                                                            //   ),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          //returns view
                          child: Container(
                            height: 736.h,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 56.h),
                              child: ListView.builder(
                                itemCount: c.returnsList.length,
                                itemBuilder: (context, index) {
                                  List<TableRow> tableRowsHere =
                                      c.returnsTableMaker(c.returnsList[index].materialsReturn!);
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        c.toggleExpansion(index);
                                      },
                                      child: Slidable(
                                        enabled: c.isExpanded2[index] ? false : true,
                                        endActionPane: ActionPane(
                                          extentRatio: 0.3,
                                          motion: StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (ctx) async {
                                                await c.denyReturns(
                                                    slotId: c.returnsList[index].slotId!, context: context);
                                              },
                                              icon: Icons.delete,
                                              backgroundColor: AppColors.errorColor,
                                              borderRadius: BorderRadius.circular(10),
                                              spacing: 0,
                                              padding: EdgeInsets.zero,
                                            )
                                          ],
                                        ),
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 400),
                                          height: c.isExpanded2[index] ? 400 : 96,
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: c.isExpanded2[index] ? AppColors.lightBlue : AppColors.lightBlue,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      AppText(
                                                        text: c.returnsList[index].remarks ?? 'Remarks',
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
                                                            text: c.returnsList[index].retBy!.name ?? '',
                                                            color: AppColors.txtColor,
                                                            size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                            fontFamily: AppFonts.interRegular,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          SizedBox(width: 32.w),
                                                          AppText(
                                                            text:
                                                                'Date: ${c.returnsList[index].retTime.toString().substring(0, 10)}',
                                                            color: AppColors.txtColor,
                                                            size: MediaQuery.of(context).size.width > 400 ? 16 : 16.h,
                                                            fontFamily: AppFonts.interRegular,
                                                            fontWeight: FontWeight.w400,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      c.approveReturns(
                                                        slotId: c.returnsList[index].slotId!,
                                                        context: context,
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        padding: EdgeInsets.all(16),
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        backgroundColor: AppColors.btnColor),
                                                    child: Icon(Icons.check),
                                                  ),
                                                ],
                                              ),
                                              c.isExpanded2[index]
                                                  ? Padding(
                                                      padding: const EdgeInsets.only(top: 16),
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
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
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
