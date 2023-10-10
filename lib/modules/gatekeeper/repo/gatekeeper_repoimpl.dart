import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/gatekeeper/gatekeeper_model.dart';
import 'package:tethys/modules/gatekeeper/repo/gatekeeper_repo.dart';

class GateKeepRepoImpl extends GateKeepRepo {
  ApiService apiService = ApiService();

  Future<OrdersList> getOrders() async {
    return ordersListFromJson(
      await apiService.get(Endpoints.getOrderList),
    );
  }
}
