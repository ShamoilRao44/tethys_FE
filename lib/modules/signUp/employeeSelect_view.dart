import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_strings.dart';

class EmployeeSelectionScrn extends StatelessWidget {
  const EmployeeSelectionScrn({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              26 * fem, 52 * fem, 25 * fem, 0), // Adjust padding
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33 * fem),
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
                    0 * fem, 5 * fem, 1 * fem, 0), // Adjust margin
                child: Text(
                  AppStrings.empRole,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34 * fem, // Adjust font size
                    fontWeight: FontWeight.w700,
                    height: 1.28,
                    color: AppColors.txtColor,
                  ),
                ),
              ),
              SizedBox(height: 160 * fem),
              ElevatedButton(
                onPressed: () {
                  print('object');
                  // Add functionality for the 'Owner' button
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
                      AppStrings.stockManager,
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
              SizedBox(height: 20 * fem),
              ElevatedButton(
                onPressed: () {
                  print('object5');
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
                      AppStrings.prodManager,
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
                SizedBox(height: 20 * fem),
              ElevatedButton(
                onPressed: () {
                  print('object8');
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
                      AppStrings.gateKeeper,
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
  }
}
