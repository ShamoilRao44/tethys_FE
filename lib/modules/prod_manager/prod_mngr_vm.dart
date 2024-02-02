// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/requisition_list_model.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_repo/prod_mngr_repo_impl.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_dashboard.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/requisition_return.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ProdMngrVM extends GetxController {
  RxInt indx = 0.obs;
  String selectedOption = 'Request Material';
  ProdMngrRepoImpl pmri = ProdMngrRepoImpl();
  Widget? child = ProdMngrDashboard();
  List<TableRow> tableRows = [];
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();

  List<ReqListDatum> pendingRequisitionsList = [];

  List<String> itemNameList = [];
  List<MaterialInfo>? materials = [];
  List<Map>? sendApiList = [];

  List<bool> isExpanded = [];

  late RequisitionListModel requisitions;

  @override
  void onInit() {
    super.onInit();
    fetchMaterialList();
    fetchRequisitionList();
  }

  Future<void> fetchMaterialList() async {
    await pmri.getItemsList().then(
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

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = ProdMngrDashboard();
        break;
      case 1:
        child = RequisitionReturnView();
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
            'id': element.id,
            'qty': itemQtyCtrl.text,
          });
        }
      },
    );
    update();

    debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendRequest(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRow();
    }
    var data = {};

    data['items'] = sendApiList;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = remarkCtrl.text;

    debugPrint(data.toString());

    await pmri.requestItems(data).then(
      (res) async {
        debugPrint('success');
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Request sent succesfully',
            color: AppColors.snackBarColorSuccess,
          ));
          await fetchRequisitionList();
          update();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Request Not sent',
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    );
    remarkCtrl.clear();
    tableRows.clear();
  }

  void toggleExpansion(int index) {
    isExpanded[index] = !isExpanded[index];
    update(); // Trigger a UI update
  }

  Future<void> fetchRequisitionList() async {
    pendingRequisitionsList.clear();
    var data = {};
    data['emp_id'] = await SecuredStorage.readStringValue(Keys.id);
    debugPrint(data.toString());

    await pmri.getRequisitionList(data).then(
      (res) {
        if (res.status == '200') {
          // RequisitionsList = res.data!;
          res.data!.forEach(
            (element) {
              if (element.issueTime == null) {
                pendingRequisitionsList.add(element);
              }
            },
          );
          isExpanded = List.generate(pendingRequisitionsList.length, (index) => false);
        } else {
          debugPrint(res.msg);
        }
      },
    ).onError((error, stackTrace) => null);
  }

  Future<void> returnMaterial(BuildContext context) async {
    var data = {};

    data['items'] = sendApiList;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = remarkCtrl.text;

    await pmri.returnMaterial(data).then(
      (res) {
        debugPrint('success');
        if (res.status == '200') {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Return Meterial Successfull',
            color: AppColors.snackBarColorSuccess,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
            msg: 'Something went wrong',
            color: AppColors.snackBarColorFailure,
          ));
        }
      },
    ).onError((error, stackTrace) => null);

    tableRows.clear();
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
}
