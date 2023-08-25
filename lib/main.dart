// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tethys/modules/login/login_views/login_view.dart';
// // import 'package:tethys/modules/login/login_views/login_view.dart';
// import 'package:tethys/modules/login/login_views/splash_view.dart';
// import 'package:tethys/modules/signUp/roleSelection_view.dart';
// // import 'package:tethys/modules/signUp/roleSelection_view.dart';

// // import 'package:tethys/modules/login/login_views/splash_view.dart';

// import 'modules/signUp/signUp_view.dart';
// import 'resources/app_routes.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(),
//         home: SplashView(),
//         getPages: [
//           GetPage(
//             name: AppRoutes.roleSelectScreen,
//             page: () => RoleSelectScreen(),
//             binding: SignupBinding(),
//           ),
//           GetPage(
//             name: AppRoutes.signupScrn,
//             page: () => SignupView(),
//             binding: SignupBinding(),
//           ),
//           // GetPage(
//           //   name: AppRoutes.loginView,
//           //   page: () => LoginView(),
//           // ),
//           // GetPage(
//           //   name: AppRoutes.loginView,
//           //   page: () => LoginView(),
//           // ),
//         ]);
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/login/login_views/login_view.dart';
// import 'package:tethys/modules/login/login_views/login_view.dart';
import 'package:tethys/modules/login/login_views/splash_view.dart';
import 'package:tethys/modules/owner/views/owner_home_view.dart';
import 'package:tethys/modules/signup/signup_views/otp_view.dart';
import 'package:tethys/modules/signup/signup_views/roleSelection_view.dart';
import 'package:tethys/utils/bindings.dart';
// import 'package:tethys/modules/signUp/roleSelection_view.dart';

// import 'package:tethys/modules/login/login_views/splash_view.dart';

import 'modules/signup/signup_views/signUp_view.dart';
import 'resources/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        // home: SignupView(),
        home: SplashView(),
        getPages: [
          GetPage(
            name: AppRoutes.loginView,
            page: () => LoginView(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: AppRoutes.ownerHome,
            page: () => OwnerHome(),
            binding: OwnerBinding(),
          ),
          GetPage(
            name: AppRoutes.roleSelectScreen,
            page: () => RoleSelectScreen(),
            binding: SignupBinding(),
          ),
          GetPage(
            name: AppRoutes.signupScrn,
            page: () => SignupView(),
            binding: SignupBinding(),
          ),
          // GetPage(
          //   name: AppRoutes.loginView,
          //   page: () => LoginView(),
          // ),
          // GetPage(
          //   name: AppRoutes.loginView,
          //   page: () => LoginView(),
          // ),
        ]);
  }
}
