import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../resources/app_colors.dart';
import 'stock_mngr_vm.dart';

class StockMngrHome extends StatelessWidget {
  StockMngrHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.bgGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              // child: c.child,
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.boxShadow,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Obx(() {
              return GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: [
                  GButton(
                    icon: Icons.dashboard,
                    text: 'Dashboard',
                  ),
                  GButton(
                    icon: Icons.rate_review_rounded,
                    text: 'Material Request',
                  ),
                  GButton(
                    icon: CupertinoIcons.doc,
                    text: 'Order & Consignment',
                  ),
                  
                ],
                // selectedIndex: c.indx.value,
                onTabChange: (index) {
                  // c.onTabChange(index);
                },
              );
            }),
          ),
        ),
      );
    });
  }
}