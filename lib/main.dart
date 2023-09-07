import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_views/login_view.dart';
import 'package:tethys/modules/login/login_views/splash_view.dart';
import 'package:tethys/modules/owner/views/owner_home_view.dart';
import 'package:tethys/modules/signup/signup_view.dart';
import 'package:tethys/utils/bindings.dart';
import 'resources/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(481, 926),
      builder: (context, child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: SplashView(),
            getPages: [
              GetPage(
                name: AppRoutes.loginView,
                page: () => const LoginView(),
                binding: LoginBinding(),
              ),
              GetPage(
                name: AppRoutes.signupView,
                page: () => const SignupView(),
                binding: SignupBinding(),
              ),
              GetPage(
                name: AppRoutes.ownerHome,
                page: () => OwnerHome(),
                binding: OwnerBinding(),
              ),
            ]);
      },
    );
  }
}
