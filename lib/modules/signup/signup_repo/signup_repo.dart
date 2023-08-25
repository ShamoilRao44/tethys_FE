import 'package:tethys/modules/signup/signup_model.dart';

abstract class SignupRepo {
  Future<SignUpModel> ownerCreate(Map data);
  Future<OtpModel> getOtp(Map data);
}
