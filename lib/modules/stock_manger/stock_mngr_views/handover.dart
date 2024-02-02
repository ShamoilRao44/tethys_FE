import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';

class SMHandovers extends StatelessWidget {
  const SMHandovers({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.transparent,
      );
    });
  }
}
