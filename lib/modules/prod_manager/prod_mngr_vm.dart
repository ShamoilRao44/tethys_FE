// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_repo/prod_mngr_repo_impl.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/prod_mngr_dashboard.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_views/request_material_view.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';

class ProdMngrVM extends GetxController {
  RxInt indx = 0.obs;
  ProdMngrRepoImpl pmri = ProdMngrRepoImpl();
  Widget? child = ProdMngrDashboard();
  List<TableRow> tableRows = [];
  TextEditingController itemNameCtrl = TextEditingController();
  TextEditingController itemQtyCtrl = TextEditingController();

  List<String> itemNameList = [];
  List<MaterialInfo>? materials = [];
  List<Map>? sendApiList = [];

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  Future<void> getList() async {
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
        debugPrint(materials.toString());
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
    var data = {};

    data['items'] = sendApiList;
    data['req_by'] = await SecuredStorage.readIntValue(Keys.id);
    data['remarks'] = "no remark";

    debugPrint(data.toString());

    await pmri.requestItems(data).then((res) {
      if (res.status == '200') {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(
              msg: 'Request sent succesfully',
              color: AppColors.snackBarColorSuccess),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          appSnackbar(
              msg: 'Request Not sent', color: AppColors.snackBarColorFailure),
        );
      }
    }).onError((error, stackTrace) => null);
  }
}
