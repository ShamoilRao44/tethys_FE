import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/prod_manager/models/request_items_model.dart';

abstract class ProdMngrRepo {
  Future<GetItemsListModel> getItemsList();
  Future<RequestItemsModel> requestItems(Map data);
}
