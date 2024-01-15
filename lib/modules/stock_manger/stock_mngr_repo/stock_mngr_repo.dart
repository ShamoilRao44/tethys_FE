import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/models/approve_returns_model.dart';
import 'package:tethys/modules/stock_manger/models/deny_request_model.dart';
import 'package:tethys/modules/stock_manger/models/deny_returns_model.dart';
import 'package:tethys/modules/stock_manger/models/get_inventory_model.dart';
import 'package:tethys/modules/stock_manger/models/get_orders_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/models/issue_request_model.dart.dart';
import 'package:tethys/modules/stock_manger/models/send_order_model.dart';

abstract class StockMngrRepo {
  Future<GetInventoryModel> getInventory();
  Future<GetItemsListModel> getItemsList();
  Future<MaterialRequestModel> getrequests();
  Future<IssueRequesitionsModel> issueRequest(Map data);
  Future<DenyRequestModel> denyRequest(Map data);
  Future<GetReturnsListModel> fetchReturns();
  Future<ApproveReturnsModel> approveReturn(Map data);
  Future<DenyReturnsModel> denyReturns(Map data);
  Future<OrdersListForSMngr> getOrders();
  Future<SendOrderModel> sendOrder(Map data);
}
