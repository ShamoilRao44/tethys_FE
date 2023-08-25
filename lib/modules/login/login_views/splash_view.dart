import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'package:tethys/modules/login/login_views/login_view.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // continueAnimation();
    Timer(
      const Duration(seconds: 2), () => Get.toNamed(AppRoutes.loginView),
      //       () => Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (context) => const LoginView()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(AppImages.splash))));
  }
}
