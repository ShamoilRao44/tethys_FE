// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/gatekeeper/models/gatekeeper%20_model.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_orders_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/request_and_returns.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/order_consgnmnt.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
  StockMngrRepoImpl smri = StockMngrRepoImpl();
  RxInt indx = 0.obs;
  Widget? child = StockMngrDashboard();
  bool isApproved = false;
  bool isRequests = true;
  List<bool> isExpanded = [];
  List<bool> isExpanded2 = [];
  List<bool> isExpandedForOrders = [];
  List<TableRow> tableRows = [];
  List<String> itemNameList = [];
  List<MaterialInfo>? materials = [];
  List<Map>? sendApiList = [];

  OrdersDatum ordersObj = OrdersDatum();

  List<MaterialReqDatum> materialReqList = [];
  List<ReturnsDatum> returnsList = [];
  List<OrdersDatum> ordersList = [];
  TextEditingController suppNameCtrl = TextEditingController();
  TextEditingController totalAmtCtrl = TextEditingController();
  TextEditingController invoiceCtrl = TextEditingController();
  TextEditingController vehicleCtrl = TextEditingController();
  TextEditingController remarksCtrl = TextEditingController();
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();

  // TextEditingController expDateCtrl = TextEditingController();
  // TextEditingController pur = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getRequests();
    fetchMaterialList();
    fetchReturns();
  }

  Future<void> getRequests() async {
    materialReqList.clear();
    await smri.getrequests().then((res) {
      if (res.status == '200') {
        // materialReqList = res.data!;
        res.data!.forEach(
          (element) {
            if (element.issueStatus == false) {
              materialReqList.add(element);
            }
          },
        );
        isExpanded = List.generate(materialReqList.length, (index) => false);
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

  void toggleExpansion(int index) {
    if (isRequests == true) {
      isExpanded[index] = !isExpanded[index];
    } else {
      isExpanded2[index] = !isExpanded2[index];
    }
    update(); // Trigger a UI update
  }

  Future<void> fetchMaterialList() async {
    await smri.getItemsList().then(
      (res) {
        if (res.status == "200") {
          res.data!.forEach((element) {
            itemNameList.add(
              element.material!.toLowerCase(),
            );
          });
          materials = res.data;
        }
      },
    );
  }

  void addRow() async {
    tableRows.add(
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              itemNameCtrl.text,
              maxLines: 2,
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

    materials!.forEach(
      (element) {
        if (itemNameCtrl.text == element.material!.toLowerCase()) {
          sendApiList!.add({
            'm_id': element.id,
            'ord_qty': itemQtyCtrl.text,
          });
        }
      },
    );
    update();

    // debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendOrder(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRow();
    }

    var data = {};

    data['supp_name'] = suppNameCtrl.text;
    data['t_amount'] = totalAmtCtrl.text;
    data['invoice'] = invoiceCtrl.text;
    data['vehicle'] = vehicleCtrl.text;
    data['remarks'] = remarksCtrl.text;
    data['exp_date'] = DateTime.now().toString();
    data['pur_by'] = await SecuredStorage.readStringValue(Keys.id);
    data['orders'] = sendApiList;

    debugPrint(data.toString());
    // debugPrint('test');

    // suppNameCtrl.clear();
    // totalAmtCtrl.clear();
    // invoiceCtrl.clear();
    // vehicleCtrl.clear();
    // remarksCtrl.clear();
    // sendApiList!.clear();

    await smri.sendOrder(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Succesfully Uploaded Purchases',
            color: AppColors.snackBarColorSuccess));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure));
      }
    });
  }

  List<TableRow> requestTableMaker(List<Requisition> requestList) {
    List<TableRow> reqMaterialTableRows = [];
    requestList.forEach(
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

  Future<void> approveRequest(
      {required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.issueRequest(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        await getRequests();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }

  Future<void> fetchReturns() async {
    returnsList.clear();
    await smri.fetchReturns().then((res) {
      res.data!.forEach(
        (element) {
          returnsList.add(element);
        },
      );
    }).onError((error, stackTrace) => null);
    isExpanded2 = List.generate(returnsList.length, (index) => false);
  }

  void toggleViews(bool value) {
    isRequests = value;
    update();
  }

  List<TableRow> returnsTableMaker(List<MaterialsReturn> returnsList) {
    List<TableRow> retMaterialTableRows = [];
    returnsList.forEach(
      (element) {
        retMaterialTableRows.add(
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
                  text: element.qtyRet.toString(),
                  color: AppColors.txtColor,
                  size: 16,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return retMaterialTableRows;
  }

  Future<void> fetchOrders() async {
    smri.getOrders().then((res) {
      if (res.status == '200') {
        ordersList.clear();
        res.data!.forEach((element) {
          ordersList.add(element);
        });
      }
    }).onError((error, stackTrace) => null);
    isExpandedForOrders = List.generate(ordersList.length, (index) => false);
  }

  void toggleExpansionForOrders(int index) {
    isExpandedForOrders[index] = !isExpandedForOrders[index];
    update(); // Trigger a UI update
  }

  List<TableRow> ordersTableMaker(List<OrderDetails> ordersListFromUi) {
    List<TableRow> ordersListForTableMaker = [];
    ordersListFromUi.forEach(
      (element) {
        ordersListForTableMaker.add(
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
    return ordersListForTableMaker;
  }
}
