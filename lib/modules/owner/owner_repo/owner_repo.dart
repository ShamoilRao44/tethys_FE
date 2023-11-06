import 'package:tethys/modules/owner/owner_model.dart';

abstract class OwnerRepo {
  Future<EmployeeRequestModel> getEmpReq();
  Future<AcceptReqResponse> postEmpReq(data);
  Future<DeleteReqResponse> deleteReq(Map data);
}
