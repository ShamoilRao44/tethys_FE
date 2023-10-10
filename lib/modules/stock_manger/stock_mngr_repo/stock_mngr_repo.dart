import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/models/send_order_model.dart';

abstract class StockMngrRepo {
  Future<GetItemsListModel> getItemsList();
  Future<MaterialRequestModel> getrequests();
  Future<SendOrderModel> sendOrder(Map data);
}
