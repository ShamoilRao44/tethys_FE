// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_vm.dart';
import 'package:tethys/modules/signup/signup_views/roleSelection_view.dart';
import 'package:tethys/modules/signup/signup_vm.dart';
import 'package:tethys/resources/app_routes.dart';
// import 'package:tethys/resources/app_colors.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_images.dart';
import '../../../resources/app_strings.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    Get.put(SignupVM());

    return GetBuilder<SignupVM>(builder: (c) {
      return Scaffold(
        body: Center(
          child: Stack(children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      AppImages.bgImage), // Replace with your image path
                ),
              ),
            ),
            Positioned(
              left: 45 * fem,
              top: 246 * fem,
              child: Align(
                child: SizedBox(
                  width: 301 * fem,
                  height: 360 * fem,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20 * fem),
                      border: Border.all(color: AppColors.fluoroscentBlue),
                      gradient: LinearGradient(
                        begin: Alignment(-0.173, -1),
                        end: Alignment(-0.158, 1),
                        colors: <Color>[
                          AppColors.lightBlue,
                          AppColors.beige,
                        ],
                        stops: <double>[0, 1],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          offset: Offset(0 * fem, 8 * fem),
                          blurRadius: 12 * fem,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   left: 74 * fem,
            //   top: 341 * fem,
            //   child: Align(
            //     child: SizedBox(
            //       width: 243 * fem,
            //       height: 59 * fem,
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20 * fem),
            //             borderSide: BorderSide(
            //               color: AppColors.fieldBorder,
            //             ),
            //           ),
            //           filled: true,
            //           fillColor: AppColors.txtField,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 74 * fem,
            //   top: 408 * fem,
            //   child: Align(
            //     child: SizedBox(
            //       width: 243 * fem,
            //       height: 56 * fem,
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20 * fem),
            //             borderSide: BorderSide(
            //               color: AppColors.fieldBorder,
            //             ),
            //           ),
            //           filled: true,
            //           fillColor: AppColors.txtField,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              left: 95 * fem - 10,
              top: 360 * fem - 40,
              child: Align(
                child: SizedBox(
                  width: 200 * fem + 20,
                  height: 32 * fem + 16,
                  child: Container(
                    height: 32 * fem + 20,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border:
                            Border.all(color: AppColors.fieldBorder, width: 2)),
                    child: TextFormField(
                      controller: c.emailCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtField,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: AppStrings.email,
                        labelStyle: TextStyle(
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 95 * fem - 10,
              top: 400 * fem - 20, // Adjust this position as needed
              child: Align(
                child: SizedBox(
                  width: 200 * fem + 20,
                  height: 32 * fem + 16,
                  child: Container(
                    height: 32 * fem + 20,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border:
                            Border.all(color: AppColors.fieldBorder, width: 2)),
                    child: TextFormField(
                      controller: c.passwordCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtField,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: AppStrings.otp,
                        labelStyle: TextStyle(
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     left: 120 * fem,
            //     top: 440 * fem,
            //     child: Align(
            //         child: SizedBox(
            //             width: 160 * fem,
            //             height: 24 * fem,
            //             child: Text(
            //               AppStrings.forgotpass,
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontSize:
            //                     15 * fem, // Adjust the font size as needed
            //                 color: AppColors.black,
            //               ),
            //             )))),
            Positioned(
              left: 120 * fem, // Adjust the left value as needed
              top: 480 * fem,
              child: Align(
                child: SizedBox(
                  width: 151 * fem,
                  height: 46 * fem,
                  child: ElevatedButton(
                    onPressed: () {
                      c.getOtp();
                      // Add your login button functionality here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors
                          .darkblue, // Change the button color as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20 * fem),
                      ),
                    ),
                    child: Text(
                      AppStrings.getotp,
                      style: TextStyle(
                        fontSize: 20 * fem,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     left: 96 * fem,
            //     top: 544 * fem,
            //     child: Container(
            //       width: 200.5 * fem,
            //       height: 19 * fem,
            //       child: Row(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(AppStrings.account,
            //                 style: TextStyle(
            //                   fontSize: 14 * fem,
            //                   color: AppColors.black,
            //                 )),
            //             GestureDetector(
            //               onTap: () => Get.offNamed(AppRoutes.roleSelectScreen),
            //               child: Text(
            //                 AppStrings.signup,
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 14 * fem,
            //                   fontWeight: FontWeight.w400,
            //                   height: 1.21 * fem / fem,
            //                   color: AppColors.darkblue,
            //                 ),
            //               ),
            //             ),
            //           ]),
            //     ))
          ]),
        ),
      );
    });
  }
}
