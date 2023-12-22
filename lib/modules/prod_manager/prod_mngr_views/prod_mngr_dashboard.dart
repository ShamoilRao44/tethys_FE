// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/prod_manager/prod_mngr_vm.dart';
import 'package:tethys/resources/app_colors.dart';
import 'package:tethys/resources/app_fonts.dart';
import 'package:tethys/resources/app_images.dart';
import 'package:tethys/resources/app_routes.dart';
import 'package:tethys/utils/common.dart';
import 'package:tethys/utils/widgets/app_text.dart';

class ProdMngrDashboard extends StatelessWidget {
  const ProdMngrDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProdMngrVM>(builder: (c) {
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
            padding: const EdgeInsets.all(16.0),
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
                              dashboardCard(
                                text1: 'Pending Material Requests',
                                text2: c.pendingRequisitionsList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Pending Return Requests',
                                text2: c.returnsList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Unverified Handovers',
                                // text2: c.ordersList.length.toString(),
                              ),
                              dashboardCard(
                                text1: 'Approved Requests',
                                // text2: c.ordersList.length.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              c.invntryTableMaker();
                              Get.toNamed(AppRoutes.pmInventory);
                            },
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
