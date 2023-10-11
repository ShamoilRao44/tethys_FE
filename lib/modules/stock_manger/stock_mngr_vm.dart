// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/material_request_view.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/order_consgnmnt.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';
import 'stock_mngr_dashboard.dart';

class StockMngrVM extends GetxController {
  StockMngrRepoImpl smri = StockMngrRepoImpl();
  RxInt indx = 0.obs;
  Widget? child = StockMngrDashboard();
  bool isApproved = false;
  List<bool> isExpanded = [];
  List<TableRow> tableRows = [];
  List<String> itemNameList = [];
  List<MaterialInfo>? materials = [];
  List<Map>? sendApiList = [];

  List<MaterialReqDatum> materialReqList = [];
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
  }

  Future<void> getRequests() async {
    await smri.getrequests().then((res) {
      if (res.status == '200') {
        materialReqList = res.data!;
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
    isExpanded[index] = !isExpanded[index];
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
    data['exp_date'] = DateTime.now();
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
        ScaffoldMessenger.of(context)
            .showSnackBar(appSnackbar(msg: 'Succesfully Uploaded Purchases'));
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

    await smri.issueRequest(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorSuccess),
        );
        getRequests();
        update();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(msg: res.msg, color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }
}
