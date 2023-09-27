// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/material_request_view.dart';
import 'package:tethys/modules/stock_manger/order_consgnmnt.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
  StockMngrRepoImpl smri = StockMngrRepoImpl();
  RxInt indx = 0.obs;
  Widget? child = StockMngrDashboard();
  List<TableRow> tableRows = [];

  @override
  void onInit() {
    super.onInit();
    getRequests();
  }

  Future<void> getRequests() async {
    await smri.getrequests().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          tableRows.add(
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.material!.name!,
                    textAlign: TextAlign.center,
                    size: 16,
                    color: AppColors.txtColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: element.qty.toString(),
                    textAlign: TextAlign.center,
                    size: 16,
                    color: AppColors.txtColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          );
        });
      }
    });
  }

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = StockMngrDashboard();
        break;
      case 1:
        child = MaterialRequestView();
        break;
      case 2:
        child = OrderConsgnmnt();
        break;
    }
    update();
  }
}
