import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GatekeeperView extends StatelessWidget {
  const GatekeeperView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: Text('GateKeeper'),
        ),
      );
    });
  }
}
