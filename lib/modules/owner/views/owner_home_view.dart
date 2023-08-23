// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tethys/resources/app_colors.dart';

import 'owner_dashboard_view.dart';

// ignore: must_be_immutable
class OwnerHome extends StatefulWidget {
  OwnerHome({super.key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Widget? child = OwnerDashboard();
    switch (_index) {
      case 0:
        child = OwnerDashboard();
        break;
      case 1:
        child =UserScrn();
        break;
      case 2:
        child = ListTilesWithButtons() ;
        break;
    }
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xfff4faff), Color(0xffacd2e3)],
            stops: <double>[0, 1],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: child,
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.boxShadow,
                borderRadius: BorderRadius.circular(30)),
            child: GNav(
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
                  icon: Icons.list_sharp,
                  text: 'User List',
                ),
                GButton(
                  icon: Icons.rate_review,
                  text: 'Request',
                ),
              ],
              selectedIndex: _index,
              onTabChange: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
