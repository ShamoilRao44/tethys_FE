import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
   RxInt indx = 0.obs;
    Widget? child = StockMngrDashboard();
 void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = StockMngrDashboard();
        break;
      case 1:
        // child = MaterialRequest();
        break;
      case 2:
        // child = ProdMngrDashboard();
        break;
    }

    update();
  }
}
