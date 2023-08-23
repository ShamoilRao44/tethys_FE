import 'package:tethys/modules/signup/signup_model.dart';

abstract class SignupRepo {
  Future<OwnerCreateModel> ownerCreate(Map data);
  Future<OtpModel> getOtp(Map data);
}
