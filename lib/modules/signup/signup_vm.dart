import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo_impl.dart';
import 'package:tethys/resources/app_routes.dart';

class SignupVM extends GetxController {
  SignupRepoImpl suri = SignupRepoImpl();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> signup() async {
    var data = {};

    data['name'] = nameCtrl.text;
    data['email'] = emailCtrl.text;
    debugPrint(emailCtrl.text);
    data['role'] = roleCtrl.text == 'Stock Manager'
        ? 1
        : roleCtrl.text == 'Product Manager'
            ? 2
            : 3;
    data['phone'] = phoneCtrl.text;
    data['password'] = passwordCtrl.text;

    await suri.signup(data).then(
      (res) {
        if (res.status == "200") {
          debugPrint('success');
          Get.offNamed(AppRoutes.loginView);
        } else {
          debugPrint(res.detail);
        }
      },
    );
  }
}
