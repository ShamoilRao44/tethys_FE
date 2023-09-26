import 'package:get/get.dart';
import 'package:tethys/resources/app_routes.dart';

Future<void> logout() async {
  Get.offNamed(AppRoutes.loginView);
}
