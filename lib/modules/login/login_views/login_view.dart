import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/signUp/roleSelection_view.dart';
// import 'package:tethys/resources/app_colors.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_images.dart';
import '../../../resources/app_strings.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

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
          Positioned(
            left: 74 * fem,
            top: 341 * fem,
            child: Align(
              child: SizedBox(
                width: 243 * fem,
                height: 59 * fem,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                      borderSide: BorderSide(
                        color: AppColors.fieldBorder,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtField,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 74 * fem,
            top: 408 * fem,
            child: Align(
              child: SizedBox(
                width: 243 * fem,
                height: 56 * fem,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                      borderSide: BorderSide(
                        color: AppColors.fieldBorder,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.txtField,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 95 * fem,
            top: 357.5 * fem,
            child: Align(
              child: SizedBox(
                width: 159 * fem,
                height: 24 * fem,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: AppStrings.username,
                    labelStyle: TextStyle(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.2125 * fem,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 95 * fem,
            top: 424.5 * fem, // Adjust this position as needed
            child: Align(
              child: SizedBox(
                width: 159 * fem,
                height: 24 * fem,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: AppStrings.password, // Adjust the label text
                    labelStyle: TextStyle(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),

                    contentPadding: EdgeInsets.symmetric(
                      vertical: 1.2125 * fem,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 129 * fem,
              top: 472 * fem,
              child: Align(
                  child: SizedBox(
                      width: 136 * fem,
                      height: 20 * fem,
                      child: Text(
                        AppStrings.forgotpass,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15 * fem, // Adjust the font size as needed
                          color: AppColors.black,
                        ),
                      )))),
          Positioned(
            left: 112 * fem, // Adjust the left value as needed
            top: 528 * fem,
            child: Align(
              child: SizedBox(
                width: 151 * fem,
                height: 46 * fem,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => RoleSelectScreen());
                    // Add your login button functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.darkblue, // Change the button color as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                  ),
                  child: Text(
                    AppStrings.login,
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
          Positioned(
              left: 90.5 * fem,
              top: 598 * fem,
              child: Container(
                width: 200.5 * fem,
                height: 19 * fem,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0* fem, 0 * fem),
                        child: Text(AppStrings.empRole,
                            style: TextStyle(
                              fontSize: 14 * fem,
                              color: AppColors.black,
                            )),
                      ),
                      Text(
                        AppStrings.signup,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          height: 1.21 * fem / fem,
                          color: AppColors.darkblue,
                        ),
                      ),
                    ]),
              ))
        ]),
      ),
    );
  }
}
