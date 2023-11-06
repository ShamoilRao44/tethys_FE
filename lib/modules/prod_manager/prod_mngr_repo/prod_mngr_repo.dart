import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';
import 'package:tethys/modules/prod_manager/models/requisition_list_model.dart';
import 'package:tethys/modules/prod_manager/models/return_material_model.dart';

abstract class ProdMngrRepo {
  Future<GetItemsListModel> getItemsList();
  Future<RequestItemsModel> requestItems(Map data);
  Future<RequisitionListModel> getRequisitionList(Map data);
  Future<ReturnMaterialModel> returnMaterial(Map data);
}
