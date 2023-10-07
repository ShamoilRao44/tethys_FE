import 'package:flutter/material.dart';
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

  @override
  Future<DeleteReqResponse> DeleteReq(Map data) async {
    debugPrint('demo');
    return deleteReqResponseFromJson(
      await apiService.delete(Endpoints.request + Endpoints.delete, data),
    );
  }

  @override
  Future<AcceptReqResponse> postEmpReq(data) async {
    debugPrint('accept');
    debugPrint(Endpoints.request + Endpoints.delete);
    return acceptReqResponseFromJson(
        await apiService.post(Endpoints.request + Endpoints.permit, data));
  }
}
