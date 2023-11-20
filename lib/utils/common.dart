import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';
import 'package:tethys/utils/widgets/app_text.dart';

Future<void> logout() async {
  SecuredStorage.clearSecureStorage();
  Get.offNamed(AppRoutes.loginView);
}

Widget dashboardCard({text1, String? text2}) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.withOpacity(0.5),
            Colors.lightBlue.withOpacity(1.0),
            Colors.blue.withOpacity(1.0),
            Colors.indigo.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text1,
                color: AppColors.white,
                size: 16.h,
              ),
              AppText(
                text: text2 ?? 0.toString(),
                color: AppColors.white,
                size: 48.h,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
