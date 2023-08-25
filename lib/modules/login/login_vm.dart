import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_repo/login_repo_impl.dart';
import 'package:tethys/resources/app_routes.dart';

class LoginVM extends GetxController {
  LoginRepoImpl lri = LoginRepoImpl();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  

  Future<void> login() async {
    var data = {};

    data['username'] = usernameCtrl.text.trim();
    data['password'] = passwordCtrl.text.trim();

    debugPrint(data.toString());

    await lri.login(data).then(
      (res) {
        if (res.status == '200') {
          debugPrint('success login');
          Get.offAllNamed(AppRoutes.ownerHome);
        } else {
          debugPrint('failed');
        }
      },
    );
  }
}
