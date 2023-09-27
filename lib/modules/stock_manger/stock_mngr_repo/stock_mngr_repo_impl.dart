import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/stock_manger/models/get_request_list_model.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_repo/stock_mngr_repo.dart';

class StockMngrRepoImpl extends StockMngrRepo {
  ApiService apiService = ApiService();

  Future<MaterialRequestModel> getrequests() async {
    return materialRequestModelFromJson(
      await apiService.get(Endpoints.getRequestsList),
    );
  }
}
