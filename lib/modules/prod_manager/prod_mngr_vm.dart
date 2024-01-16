// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_pm_Inventory_model.dart';
import 'package:tethys/modules/prod_manager/models/get_returns_model.dart';
import 'package:tethys/modules/prod_manager/models/requisition_list_model.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_repo/prod_mngr_repo_impl.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_dashboard.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/production_handover.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/requisition_return.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ProdMngrVM extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxInt indx = 0.obs;
  String selectedOption = 'Request Material';
  ProdMngrRepoImpl pmri = ProdMngrRepoImpl();
  Widget? child = ProdMngrDashboard();
  bool isRequests = true;
  List<TableRow> tableRows = [];
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController handoverTitleCtrl = TextEditingController();

  List<ReqListDatum> pendingRequisitionsList = [];
  List<ReturnsDatum> returnsList = [];
  List<PmInventoryDatum> inventoryList = [];

  List<String> itemNameList = [];
  List<MaterialInfo>? materials = [];
  List<Map> sendApiList = [];
  List<TableRow> invntryTableRows = [];
  List<Requisition> currentReqMaterials = [];
  var currentReqSlotId;
  List<Map<String?, dynamic>> returnedMaterialsList = [];

  List<bool> isExpanded = [];
  List<bool> isExpanded2 = [];

  late RequisitionListModel requisitions;

  @override
  void onInit() async {
    super.onInit();
    await fetchMaterialList();
    await fetchRequisitionList();
    await fetchReturns();
    await fetchPmInventory();
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

  Future<void> fetchPmInventory() async {
    await pmri.getPmInventroy().then((res) {
      if (res.status == '200') {
        res.data!.forEach((element) {
          inventoryList.add(element);
        });
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
      update();
      ++count;
    });
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
        child = ProductionHandover();
        break;
    }

    update();
  }

  void toggleViews(bool value) {
    isRequests = value;
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
    if (isRequests == true) {
      isExpanded[index] = !isExpanded[index];
    } else {
      isExpanded2[index] = !isExpanded2[index];
    }
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
              pendingRequisitionsList.add(element);
            },
          );
          update();
          isExpanded = List.generate(pendingRequisitionsList.length, (index) => false);
        } else {
          debugPrint(res.msg);
        }
      },
    ).onError((error, stackTrace) => null);
  }

  Future<void> returnMaterial(BuildContext context) async {
    var data = {};
    data['items'] = returnedMaterialsList;
    data['req_slot_id'] = currentReqSlotId;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = remarkCtrl.text;
    debugPrint(data.toString());
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
    ).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(appSnackbar(
        msg: 'Something went wrong',
        color: AppColors.snackBarColorFailure,
      ));
    });
    tableRows.clear();
  }

  Future<void> fetchReturns() async {
    returnsList.clear();

    var data = {};

    data['emp_id'] = await SecuredStorage.readIntValue(Keys.id);

    await pmri.fetchReturns(data).then((res) {
      res.data!.forEach(
        (element) {
          if (element.approved == false) {
            returnsList.add(element);
          }
        },
      );
    }).onError((error, stackTrace) => null);
    isExpanded2 = List.generate(returnsList.length, (index) => false);
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: element.qtyIssued.toString(),
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

  void addRowForHandover() {
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

    sendApiList.add({
      'p_name': itemNameCtrl.text,
      'qty': itemQtyCtrl.text,
    });

    debugPrint(sendApiList.toString());

    itemNameCtrl.clear();
    itemQtyCtrl.clear();
    update();
  }

  Future<void> sendHandover(BuildContext context) async {
    if (itemNameCtrl.text.isNotEmpty && itemQtyCtrl.text.isNotEmpty) {
      addRowForHandover();
    }

    var data = {};

    data['prods'] = sendApiList;
    data['hand_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = handoverTitleCtrl.text;

    debugPrint(data.toString());
  }

  void returnMaterialsButton(List<Requisition> a, var b) {
    returnedMaterialsList.clear();
    currentReqMaterials = a;
    currentReqSlotId = b;
    Get.toNamed(AppRoutes.returnMaterials);
  }
}
