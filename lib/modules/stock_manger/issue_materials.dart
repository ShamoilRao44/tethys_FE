// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class IssueMaterials extends StatelessWidget {
  const IssueMaterials({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
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
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppText(
                        text: 'Issue Materials',
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
                    height: 800.h,
                    child: Form(
                      key: c.formKey,
                      child: ListView.builder(
                        itemCount: c.currentRequesitions.length,
                        itemBuilder: (context, index) {
                          final item = c.currentRequesitions[index].matDetails!.material;
                          c.issuedQtyList.add({'id': c.currentRequesitions[index].reqId});
                          c.issuedQtyList[index]['qty'] = 0;
                          final remainingQuantity =
                              c.currentRequesitions[index].qtyReq! - c.currentRequesitions[index].qtyIssued!;

                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: ListTile(
                              title: Text(item!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Total Asked: ${c.currentRequesitions[index].qtyReq.toString()}'),
                                  Text('Remaining: $remainingQuantity'),
                                  Text('Issued: ${c.currentRequesitions[index].qtyIssued.toString()}'),
                                ],
                              ),
                              trailing: SizedBox(
                                width: 60,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Qty',
                                  ),
                                  onChanged: (value) {
                                    final qty = int.tryParse(value);
                                    c.issuedQtyList[index]['qty'] = qty;
                                  },
                                  validator: (value) {
                                    final qty = int.parse(value ?? '0');
                                    return qty > remainingQuantity ? 'Invalid' : null;
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (c.formKey.currentState?.validate() ?? false) {
                  debugPrint(c.issuedQtyList.toString());
                  c.issueRequesitions(context);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
