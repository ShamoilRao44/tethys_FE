import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';

class StockMngrDashboard extends StatelessWidget {
  const StockMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Stock Manager'),
          backgroundColor: Colors.blue,
        ),
      );
    });
  }
}
