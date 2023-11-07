import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_returns_list_model.dart';
import 'package:tethys/modules/stock_manger/models/issue_request_model.dart.dart';
import 'package:tethys/modules/stock_manger/models/send_order_model.dart';

abstract class StockMngrRepo {
  Future<GetItemsListModel> getItemsList();
  Future<MaterialRequestModel> getrequests();
  Future<SendOrderModel> sendOrder(Map data);
  Future<IssueRequestModel> issueRequest(Map data);
  Future<GetReturnsListModel> fetchReturns();
  }
