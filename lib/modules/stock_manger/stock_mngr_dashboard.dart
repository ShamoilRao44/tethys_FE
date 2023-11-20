// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/stock_manger/stock_mngr_vm.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/utils/common.dart';

import '../../resources/app_colors.dart';
import '../../utils/widgets/app_text.dart';

class StockMngrDashboard extends StatelessWidget {
  const StockMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockMngrVM>(builder: (c) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage(AppImages.bgImage),
            opacity: 0.5,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: AppText(
                          text: 'Dashboard',
                          textAlign: TextAlign.center,
                          size: 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppFonts.interBold,
                          color: AppColors.txtColor,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'logout',
                                child: AppText(
                                  text: 'Logout',
                                  color: AppColors.txtColor,
                                ),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            if (value == 'logout') {
                              logout();
                            }
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.txtColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            children: [
                              dashboardCard(text1: 'Pending Material Requests'),
                              dashboardCard(text1: 'Pending Return Requests'),
                              dashboardCard(text1: 'Unverified Orders'),
                              dashboardCard(text1: 'Unverified Consignments'),
                            ],
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.bordeColor2,
                              minimumSize: Size(160, 80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AppText(
                                text: 'Show Inventory',
                                color: AppColors.white,
                                size: 24.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
