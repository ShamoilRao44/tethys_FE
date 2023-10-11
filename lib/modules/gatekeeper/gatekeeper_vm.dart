import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_model.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/consignment_view.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_views/order_view.dart';
import 'package:tethys/modules/gatekeeper/repo/gatekeeper_repoimpl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class GatekeeperVM extends GetxController {
  RxInt indx = 0.obs;
  Widget? child = OrderView();
  GateKeepRepoImpl gkri = GateKeepRepoImpl();
  List<Datum> orderList = [];
  List<bool> isExpanded = [];

  void onInit() {
    super.onInit();
    fetchOrdersList();
  }

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = OrderView();
        break;
      case 1:
        child = ConsignmentView();
        break;
    }

    update();
  }

  void fetchOrdersList() async {
    await gkri.getOrders().then(
      (res) {
        if (res.status == "200") {
          res.data!.forEach((ord) {
            orderList.add(ord);
          });
          isExpanded = List.generate(orderList.length, (index) => false);
          update();
        }
      },
    );

    print(orderList);
  }

  void toggleExpansion(int index) {
    isExpanded[index] = !isExpanded[index];
    update(); // Trigger a UI update
  }

  List<TableRow> orderTableMaker(List<Order> orderList) {
    List<TableRow> reqMaterialTableRows = [];
    orderList.forEach(
      (element) {
        reqMaterialTableRows.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return reqMaterialTableRows;
  }
}
