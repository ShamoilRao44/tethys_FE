// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_dashboard.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/request_material_view.dart';

class ProdMngrVM extends GetxController {
  RxInt indx = 0.obs;
  Widget? child = ProdMngrDashboard();
  List<TableRow> tableRows = [];
  Map items = {};
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = ProdMngrDashboard();
        break;
      case 1:
        child = RequestMaterialView();
        break;
      case 2:
        child = ProdMngrDashboard();
        break;
    }

    update();
  }

  void addRow() {
    tableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemNameCtrl.text,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                itemQtyCtrl.text,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
    update();

    items[itemNameCtrl.text] = itemQtyCtrl.text;
    debugPrint(items.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }
}
