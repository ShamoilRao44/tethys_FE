import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/utils/secured_storage.dart';

class ArchiveVM extends GetxController {
  var empid = SecuredStorage.readIntValue(Keys.id);
  bool isloading = true;
}
