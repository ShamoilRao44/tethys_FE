// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_material_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_inventory_model.dart';
import 'package:tethys/modules/stock_manger/models/get_orders_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/request_and_returns.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/order_consgnmnt.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
  List<Map> sendApiList = [];
  List<TableRow> invntryTableRows = [];
  List<Requisition> currentRequesitions = [];
  List<Map<String?, dynamic>> issuedQtyList = [];

  OrdersDatum ordersObj = OrdersDatum();

  List<MaterialReqDatum> materialReqList = [];
  List<ReturnsDatum> returnsList = [];
  List<OrdersDatum> ordersList = [];
  List<InventoryDatum> inventoryList = [];
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
    fetchOrders();
    fetchInventory();
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

  Future<void> fetchInventory() async {
    inventoryList.clear();
    await smri.getInventory().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          inventoryList.add(element);
        });
        update();
      }
    }).onError((error, stackTrace) => null);
  }

  void invntryTableMaker() {
    invntryTableRows.clear();
    var count = 1;
    inventoryList.forEach((element) {
      invntryTableRows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                textAlign: TextAlign.center,
                text: count.toString(),
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                textAlign: TextAlign.center,
                text: element.materialId.toString(),
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: element.matDetails!.material!,
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: '${element.availableQty} ${element.matDetails!.umo}',
                color: AppColors.txtColor,
                size: 16,
                fontFamily: AppFonts.interRegular,
              ),
            ),
          ],
        ),
      );
      ++count;
    });
    update();
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

  void toggleViews(bool value) {
    isRequests = value;
    update();
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
        debugPrint(materialReqList.toString());
        isExpanded = List.generate(materialReqList.length, (index) => false);
      }
      update();
    });
  }

  // Future<void> approveRequest({required int slotId, required BuildContext context}) async {
  //   var data = {};
  //   data['slot_id'] = slotId;
  //   data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);
  //   await smri.issueRequest(data).then((res) async {
  //     if (res.status == '200') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
  //       );
  //       await getRequests();
  //       await fetchInventory();
  //       update();
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
  //       );
  //     }
  //   }).onError((error, stackTrace) => null);
  // }

  Future<void> issueRequesitions(BuildContext context) async {
    var data = {};

    data['issue_materials'] = issuedQtyList;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.issueRequest(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorSuccess,
        ));
        await getRequests();
        update();
        Get.back();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
          msg: res.msg,
          color: AppColors.snackBarColorFailure,
        ));
      }
    }).onError((error, stackTrace) => null);
  }

  Future<void> denyRequest({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;

    debugPrint(data.toString());

    await smri.denyRequest(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        await getRequests();
        update();
        await fetchInventory();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }

  List<TableRow> requestTableMaker(List<Requisition> requestList) {
    List<TableRow> reqMaterialTableRows = [];
    bool isAvailable = false;
    requestList.forEach(
      (element) {
        int qtyRemaining = element.qtyReq! - element.qtyIssued!;
        for (int i = 0; i < inventoryList.length; i++) {
          if (element.matDetails!.id == inventoryList[i].materialId && qtyRemaining < inventoryList[i].availableQty!) {
            isAvailable = true;
          }
        }
        reqMaterialTableRows.add(
          TableRow(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.matDetails!.material.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyReq.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyIssued.toString(),
                  color: AppColors.txtColor,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: qtyRemaining.toString(),
                  color: isAvailable ? AppColors.snackBarColorSuccess : AppColors.snackBarColorFailure,
                  size: 12,
                  fontFamily: AppFonts.interRegular,
                )),
          ]),
        );
      },
    );
    return reqMaterialTableRows;
  }

  void toggleExpansion(int index) {
    if (isRequests == true) {
      isExpanded[index] = !isExpanded[index];
    } else {
      isExpanded2[index] = !isExpanded2[index];
    }
    update(); // Trigger a UI update
  }

  Future<void> fetchReturns() async {
    returnsList.clear();
    await smri.fetchReturns().then((res) {
      res.data!.forEach(
        (element) {
          if (element.approved == false) {
            returnsList.add(element);
          }
        },
      );
    }).onError((error, stackTrace) => null);
    isExpanded2 = List.generate(returnsList.length, (index) => false);
    update();
  }

  Future<void> approveReturns({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.approveReturn(data).then(
      (res) async {
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorSuccess,
          ));
          await fetchReturns();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: res.msg,
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    ).onError((error, stackTrace) => null);
  }

  Future<void> denyReturns({required int slotId, required BuildContext context}) async {
    var data = {};

    data['slot_id'] = slotId;
    data['issue_by'] = await SecuredStorage.readIntValue(Keys.id);

    await smri.denyReturns(data).then((res) async {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        await fetchReturns();
        await fetchInventory();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
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
    await smri.getOrders().then((res) {
      ordersList.clear();

      if (res.status == '200') {
        res.data!.forEach(
          (element) {
            if (element.recieved == false) {
              ordersList.add(element);
            }
          },
        );
      }
    }).onError((error, stackTrace) => null);

    isExpandedForOrders = List.generate(ordersList.length, (index) => false);
    debugPrint(isExpandedForOrders.toString());
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

  void toggleExpansionForOrders(int index) {
    isExpandedForOrders[index] = !isExpandedForOrders[index];
    update(); // Trigger a UI update
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

    await smri.sendOrder(data).then(
      (res) {
        if (res.status == '200') {
          ScaffoldMessenger.of(context)
              .showSnackBar(appSnackbar(msg: 'Succesfully Uploaded Purchases', color: AppColors.snackBarColorSuccess));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure));
        }
      },
    );

    await fetchOrders();
    update();
  }

  void issueMaterialsButton(List<Requisition> a) {
    issuedQtyList.clear();
    currentRequesitions = a;
    Get.toNamed(AppRoutes.issueMaterials);
  }
}
