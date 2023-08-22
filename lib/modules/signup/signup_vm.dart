import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo_impl.dart';

class SignupVM extends GetxController {
  SignupRepoImpl sri = SignupRepoImpl();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController secCodeCtrl = TextEditingController();

  Future<void> ownerCreate() async {
    var data = {};
    data['name'] = "";
    data['phone'] = "";
    data['email'] = emailCtrl.text.trim();
    data['password'] = passwordCtrl.text;
    data['secret_key'] = secCodeCtrl.text;

    await sri.ownerCreate(data).then(
      (res) {
        if (res.id != null) {
          debugPrint("success");
        } else {
          debugPrint("failure");
        }
      },
    );
  }
}
