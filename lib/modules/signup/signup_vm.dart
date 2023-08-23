import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo_impl.dart';
import 'package:tethys/modules/signup/signup_views/signUp_view.dart';

class SignupVM extends GetxController {
  String otptext = '';

  SignupRepoImpl sri = SignupRepoImpl();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmpassCtrl = TextEditingController();
  TextEditingController secCodeCtrl = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();

  Future<void> getOtp() async {
    var otpdata = {};
    otpdata['email'] = emailCtrl.text.trim();
    await sri.getOtp(otpdata).then(
      (res) {
        if (res.status != null) {
          debugPrint("success");
          if (res.status == '200') {
            Get.snackbar('OTP sent', 'check you email');
            otptext = res.otp!;
          }
        } else {
          debugPrint("failure");
        }
      },
    );
  }

  Future<void> submitOtp() async {
    String? field = otpcontroller.text.trim();
    if (field == null || field == ''){
      Get.snackbar('Error', 'please enter otp');
    }
    if (otptext == field) {
      print("match");
      Get.offAll(() => SignupView());
    } else {
      Get.snackbar('Failed', 'wrong otp');
    }
  }

  Future<void> ownerCreate() async {
    var data = {};
    data['name'] = "";
    data['phone'] = "";
    data['email'] = emailCtrl.text.trim();
    data['password'] = passwordCtrl.text;
    // data['secret_key'] = secCodeCtrl.text;

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
