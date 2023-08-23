import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/app_colors.dart';

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({
     
    super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30 * fem),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xfff4faff), Color(0xffacd2e3)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34 * fem, // Adjust font size
                fontWeight: FontWeight.w700,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "Nothing to show here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25 * fem, // Adjust font size
                fontWeight: FontWeight.w400,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
class ListTilesWithButtons extends StatefulWidget {
  @override
  _ListTilesWithButtonsState createState() => _ListTilesWithButtonsState();
}

class _ListTilesWithButtonsState extends State<ListTilesWithButtons> {
  List<String> items = [
    'Name 1',
    'Name 2',
    'Name 3',
    'Name 4',
    'Name 5',
    'Name 6',
    'Name 7',
    'Name 8',
    'Name 9',
    'Name 10',
    'Name 11',
    'Name 12',
  ];


  @override
  Widget build(BuildContext context) {
     double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30 * fem),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xfff4faff), Color(0xffacd2e3)],
            stops: <double>[0, 1],
          ),
        ),

    child: Column(
      children: [
         Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "Request",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34 * fem, // Adjust font size
                fontWeight: FontWeight.w700,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
          SizedBox(height: 10,),
        Container(
          height: 590,
          child: ListView.builder(
            
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle accept button press
                        // For example, you could remove the item from the list.
                        // setState(() {
                        //   items.removeAt(index);
                        // });
                      },
                      child: Text('Accept'),
                      
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle deny button press
                        // For example, you could remove the item from the list.
                        // setState(() {
                        //   items.removeAt(index);
                        // });
                      },
                      child: Text('Deny'),
                    ),
                  ],
                ),
              );
            },
           ),
        ),
      ],
    ) ));
  }
}

class UserScrn extends StatelessWidget {
  const UserScrn({
     
    super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30 * fem),
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xfff4faff), Color(0xffacd2e3)],
            stops: <double>[0, 1],
          ),
        ),
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "User List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34 * fem, // Adjust font size
                fontWeight: FontWeight.w700,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
          SizedBox(height: 200),
          Container(
            margin: EdgeInsets.fromLTRB(
                0 * fem, 50 * fem, 1 * fem, 0), // Adjust margin
            child: Text(
              "Nothing to show here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25 * fem, // Adjust font size
                fontWeight: FontWeight.w400,
                height: 1.28,
                color: AppColors.txtColor,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
