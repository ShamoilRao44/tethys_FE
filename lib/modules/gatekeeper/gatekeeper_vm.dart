import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/consignment_view.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/order_view.dart';

class GatekeeperVM extends GetxController {
   RxInt indx = 0.obs;
    Widget? child = OrderView();
  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = OrderView();
        break;
      case 1:
        child =ConsignmentView();
        break;
      // case 2:
      //   child = ProdMngrDashboard();
      //   break;
    }

    update();
  }
}
