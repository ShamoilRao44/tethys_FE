// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';

class ReturnMaterial extends StatelessWidget {
  const ReturnMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(
      builder: (c) {
        return Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          ),
        );
      },
    );
  }
}
