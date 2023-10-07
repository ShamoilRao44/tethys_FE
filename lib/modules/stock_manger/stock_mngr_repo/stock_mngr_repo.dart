import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';

abstract class StockMngrRepo {
  Future<MaterialRequestModel> getrequests();
}
