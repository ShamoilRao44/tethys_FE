import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_repo/login_repo_impl.dart';
import 'package:tethys/modules/signup/signup_views/roleSelection_view.dart';

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
        if (res.accessToken != null) {
          debugPrint('success login');
          // Get.offAll()
        } else {
          debugPrint('failed');
        }
      },
    );
  }
}
