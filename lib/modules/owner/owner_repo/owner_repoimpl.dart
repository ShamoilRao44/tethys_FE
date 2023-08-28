import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/owner/owner_model.dart';
import 'package:tethys/modules/owner/owner_repo/owner_repo.dart';

class OwnerRepoImp extends OwnerRepo {
  ApiService apiService = ApiService();

  @override
  Future<EmployeeRequestModel> getEmpReq() async {
    return employeeRequestModelFromJson(
      await apiService.get(Endpoints.request),
    );
  }
}
