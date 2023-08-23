import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signUp/signup_vm.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_images.dart';
import '../../../resources/app_strings.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
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
                height: 444 * fem,
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
          //   top: 330 * fem,
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
          //   top: 405 * fem,
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
          //   top: 480 * fem,
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
          Positioned(
            left: 95 * fem - 10,
            top: 348.5 * fem - 30,
            child: Align(
              child: SizedBox(
                width: 200 * fem + 20,
                  height: 32 * fem + 16,
                child: Container(
                    height: 32 * fem + 20,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.fieldBorder, width: 2)),
                    child: TextFormField(
                      controller: c.emailCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtField,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: AppStrings.username,
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
            top: 423.5 * fem - 30, // Adjust this position as needed
            child: Align(
              child: SizedBox(
                width: 200 * fem + 20,
                  height: 32 * fem + 16,
                child: Container(
                    height: 32 * fem + 20,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.fieldBorder, width: 2)),
                    child: TextFormField(
                      controller: c.passwordCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtField,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: AppStrings.password,
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
            top: 498.5 * fem - 30, // Adjust this position as needed
            child: Align(
              child: SizedBox(
                width: 200 * fem + 20,
                  height: 32 * fem + 16,
                child: Container(
                    height: 32 * fem + 20,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.fieldBorder, width: 2)),
                    child: TextFormField(
                      controller: c.secCodeCtrl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtField,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        labelText: AppStrings.secureCode,
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
            left: 112 * fem + 10, // Adjust the left value as needed
            top: 580 * fem,
            child: Align(
                child: SizedBox(
                    width: 148 * fem,
                    height: 46 * fem,
                    child: ElevatedButton(
                      onPressed: () {
                        c.ownerCreate();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors
                            .darkblue, // Change the button color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18 * fem),
                        ),
                      ),
                      child: Text(
                        AppStrings.submit,
                        style: TextStyle(
                          fontSize: 22 * fem,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    )),
                    ),
          )
        ])),
      );
    });
  }
}
