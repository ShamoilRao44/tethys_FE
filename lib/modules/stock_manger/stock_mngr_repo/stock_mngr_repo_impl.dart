import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/models/send_order_model.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo.dart';

class StockMngrRepoImpl extends StockMngrRepo {
  ApiService apiService = ApiService();

  @override
  Future<MaterialRequestModel> getrequests() async {
    return materialRequestModelFromJson(
      await apiService.get(Endpoints.getReqListForSmngr),
    );
  }

  @override
  Future<GetItemsListModel> getItemsList() async {
    return getItemsListModelFromJson(
      await apiService.get(Endpoints.getItemsList),
    );
  }

  @override
  Future<SendOrderModel> sendOrder(Map data) async {
    return sendOrderModelFromJson(
      await apiService.post(Endpoints.sendOrder, data),
    );
  }
}
