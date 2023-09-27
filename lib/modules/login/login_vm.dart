import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_repo/login_repo_impl.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/widgets/app_snackbar.dart';

class LoginVM extends GetxController {
  LoginRepoImpl lri = LoginRepoImpl();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  Future<void> login({required BuildContext context}) async {
    var data = {};

    data['username'] = usernameCtrl.text.trim();
    data['password'] = passwordCtrl.text.trim();

    debugPrint(data.toString());

    await lri.login(data).then(
      (res) {
        if (res.status == '200') {
          print('data');
          if (res.user!.role == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Successfully Logged In!',
                color: AppColors.snackBarColorSuccess,
              ),
            );
            Get.offNamed(AppRoutes.ownerHome);
          } else if (res.user!.isActive == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Successfully Logged In!',
                color: AppColors.snackBarColorSuccess,
              ),
            );
            if (res.user!.role == 1) {
              Get.offNamed(AppRoutes.stockMngrDashboard);
            } else if (res.user!.role == 2) {
              Get.offNamed(AppRoutes.prodMngrHome);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackbar(
                msg: 'Not Authorized',
                color: AppColors.snackBarColorFailure,
              ),
            );
          }
        } else {
          debugPrint('failed');
        }
      },
    );
  }
}
