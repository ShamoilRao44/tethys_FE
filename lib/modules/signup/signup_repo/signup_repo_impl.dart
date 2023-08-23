import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo.dart';
import 'package:tethys/modules/signup/signup_model.dart';

class SignupRepoImpl extends SignupRepo {
  ApiService apiService = ApiService();

  @override
  Future<OwnerCreateModel> ownerCreate(Map data) async {
    return ownerCreateModelFromJson(
      await apiService.post(Endpoints.owner + Endpoints.create, data),
    );
  }

  @override
  Future<OtpModel> getOtp(Map data) async {
    // TODO: implement getOtp
    return OtpModelFromJson(await apiService.post(Endpoints.otp, data));
  }
}
