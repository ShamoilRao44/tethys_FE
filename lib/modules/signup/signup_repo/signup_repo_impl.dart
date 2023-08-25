import 'package:tethys/data/remote/api_service.dart';
import 'package:tethys/data/remote/endpoints.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo.dart';
import 'package:tethys/modules/signup/signup_model.dart';

class SignupRepoImpl extends SignupRepo {
  ApiService apiService = ApiService();

  @override
  Future<SignUpModel> ownerCreate(Map data) async {
    return signUpModelFromJson(
      await apiService.post(Endpoints.owner + Endpoints.create, data),
    );
  }

  @override
  Future<OtpModel> getOtp(Map data) async {
    return OtpModelFromJson(await apiService.post(Endpoints.otp, data));
  }
}
