// ignore_for_file: annotate_overrides

import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/prod_manager/models/get_items_list_model.dart';
import 'prod_mngr_repo.dart';

class ProdMngrRepoImpl extends ProdMngrRepo {
  ApiService apiService = ApiService();

  Future<GetItemsListModel> getItemsList() async {
    return getItemsListModelFromJson(
      await apiService.get(Endpoints.getItemsList),
    );
  }
}
