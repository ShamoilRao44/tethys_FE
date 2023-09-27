import 'package:get/get.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/secured_storage.dart';

Future<void> logout() async {
  SecuredStorage.clearSecureStorage();
  Get.offNamed(AppRoutes.loginView);
}
