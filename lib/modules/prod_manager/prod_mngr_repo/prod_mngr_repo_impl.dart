// ignore_for_file: annotate_overrides

import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_pm_Inventory_model.dart';
import 'package:tethys/modules/prod_manager/models/get_returns_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';
import 'package:tethys/modules/prod_manager/models/requisition_list_model.dart';
import 'package:tethys/modules/prod_manager/models/return_material_model.dart';
import 'prod_mngr_repo.dart';

class ProdMngrRepoImpl extends ProdMngrRepo {
  ApiService apiService = ApiService();

  Future<GetPmInventoryModel> getPmInventroy() async {
    return getPmInventoryModelFromJson(
      await apiService.get(Endpoints.getPmInventory),
    );
  }

  Future<GetItemsListModel> getItemsList() async {
    return getItemsListModelFromJson(
      await apiService.get(Endpoints.getItemsList),
    );
  }

  Future<RequestItemsModel> requestItems(Map data) async {
    return requestItemsModelFromJson(
      await apiService.post(Endpoints.sendRequestforItems, data),
    );
  }

  Future<RequisitionListModel> getRequisitionList(Map data) async {
    return requisitionListModelFromJson(
      await apiService.post(Endpoints.getReqListForPmngr, data),
    );
  }

  Future<ReturnMaterialModel> returnMaterial(Map data) async {
    return returnMaterialModelFromJson(
      await apiService.post(Endpoints.returnMaterial, data),
    );
  }

  Future<GetReturnsModel> fetchReturns(Map data) async {
    return getReturnsModelFromJson(
      await apiService.post(Endpoints.getReturnsForPmngr, data),
    );
  }
}
