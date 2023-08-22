import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signUp/signup_vm.dart';
import 'package:tethys/modules/signup/signup_views/employeeSelect_view.dart';
import 'package:tethys/modules/signup/signup_views/signUp_view.dart';
import 'package:tethys/resources/app_routes.dart';
// import 'package:get/get.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_strings.dart';

class RoleSelectScreen extends StatelessWidget {
  const RoleSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GetBuilder<SignupVM>(builder: (c) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                26 * fem, 52 * fem, 25 * fem, 0), // Adjust padding
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, 1),
                colors: AppColors.bgColor,
                stops: [0, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 2 * fem, 1 * fem, 0), // Adjust margin
                  child: Text(
                    AppStrings.selectRole,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34 * fem, // Adjust font size
                      fontWeight: FontWeight.w700,
                      height: 1.28,
                      color: AppColors.txtColor,
                    ),
                  ),
                ),
                SizedBox(height: 180 * fem),
                ElevatedButton(
                  onPressed: () {
                    print('object4');
                    Get.toNamed(AppRoutes.signupScrn);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35 * fem),
                    ),
                    elevation: 0,
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 72.14 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35 * fem),
                      color: AppColors.btnColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.btnShadow,
                          offset: Offset(0 * fem, 10 * fem),
                          blurRadius: 4 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.owner,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30 * fem, // Adjust font size
                          fontWeight: FontWeight.w700,
                          height: 1.3025,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40 * fem),
                ElevatedButton(
                  onPressed: () {
                    print('object');
                    Get.off(() => EmployeeSelectionScrn());
                    // Add functionality for the 'Employee' button
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35 * fem),
                    ),
                    elevation: 0,
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 72.14 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35 * fem),
                      color: AppColors.btnColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.btnShadow,
                          offset: Offset(0 * fem, 10 * fem),
                          blurRadius: 4 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.employee,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30 * fem, // Adjust font size
                          fontWeight: FontWeight.w700,
                          height: 1.3025,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
