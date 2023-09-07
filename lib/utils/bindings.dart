import 'package:get/get.dart';
import 'package:tethys/modules/login/login_vm.dart';
import 'package:tethys/modules/signup/signup_vm.dart';

import '../modules/owner/owner_vm.dart';

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

class OwnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OwnerHomeVM());
  }
}
