import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/get_pm_Inventory_model.dart';
import 'package:tethys/modules/prod_manager/models/get_returns_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';
import 'package:tethys/modules/prod_manager/models/requisition_list_model.dart';
import 'package:tethys/modules/prod_manager/models/return_material_model.dart';

abstract class ProdMngrRepo {
  Future<GetPmInventoryModel> getPmInventroy();
  Future<GetItemsListModel> getItemsList();
  Future<RequestItemsModel> requestItems(Map data);
  Future<RequisitionListModel> getRequisitionList(Map data);
  Future<ReturnMaterialModel> returnMaterial(Map data);
  Future<GetReturnsModel> fetchReturns(Map data);
}
