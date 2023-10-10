import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';
import 'package:tethys/modules/prod_manager/models/requisitionListModel.dart';

abstract class ProdMngrRepo {
  Future<GetItemsListModel> getItemsList();
  Future<RequestItemsModel> requestItems(Map data);
  Future<RequisitionListModel> getRequisitionList(Map data);
}
