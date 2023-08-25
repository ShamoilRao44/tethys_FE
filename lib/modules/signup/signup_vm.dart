import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/views/owner_home_view.dart';
import 'package:tethys/modules/signup/signup_repo/signup_repo_impl.dart';
import 'package:tethys/modules/signup/signup_views/signUp_view.dart';

class SignupVM extends GetxController {
  String otptext = '';
  bool isowner = true;

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
    if (field == null || field == '') {
      Get.snackbar('Error', 'please enter otp');
    }
    if (otptext == field) {
      print("match");
      Get.to(() => SignupView());
    } else {
      Get.snackbar('Failed', 'wrong otp');
    }
  }

  Future<void> ownerCreate() async {
    var data = {};
    data['name'] = "name";
    data['phone'] = "958978";
    data['email'] = emailCtrl.text.trim();
    data['password'] = passwordCtrl.text;
    // data['secret_key'] = "Owner935";
    data['secret_key'] = secCodeCtrl.text.trim().toString();

    print(data);

    await sri.ownerCreate(data).then(
      (res) {
        if (res.status != null && res.status == '200') {
          debugPrint("success");
          debugPrint(res.data!.email);
          Get.offAll(() => OwnerHome());
        } else {
          debugPrint("failure");
        }
      },
    );
  }
}
