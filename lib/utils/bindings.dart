import 'package:get/get.dart';
import 'package:tethys/modules/login/login_vm.dart';
import 'package:tethys/modules/signUp/signup_vm.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginVM());
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupVM());
  }
}
