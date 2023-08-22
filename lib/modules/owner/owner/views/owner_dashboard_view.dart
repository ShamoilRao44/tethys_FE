import 'package:flutter/material.dart';

class OwnerDashboard extends StatelessWidget {
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
          Text('data')
        ]),
      ),
    );
  }
}

class NewColumns extends StatelessWidget {
  const NewColumns({
    super.key,
    required this.fem,
  });

  final double fem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 51.5 * fem),
        Text(
          'Dashboard',
          textAlign: TextAlign.center,
        ),
        Text(
          'Nothing to show here',
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            height: 83 * fem,
            decoration: BoxDecoration(
              color: Color(0xfc293241),
              borderRadius: BorderRadius.circular(30 * fem),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset('assets/page-1/images/rectangle-8-TnH.png'),
                SizedBox(width: 35.22 * fem),
                // Image.asset('assets/page-1/images/ellipse-4-nch.png'),
                SizedBox(width: 42 * fem),
                // Image.asset('assets/page-1/images/ellipse-3.png'),
              ],
            ),
          ),
        ),
        SizedBox(height: 22 * fem),
        SizedBox(
          width: 50 * fem,
          height: 33 * fem,
          // child: Image.asset('assets/page-1/images/ellipse-3.png'),
        ),
        SizedBox(height: 22 * fem),
        ClipRRect(
          borderRadius: BorderRadius.circular(30 * fem),
          child: SizedBox(
            width: 42 * fem,
            height: 35 * fem,
            // child: Image.asset('assets/page-1/images/ellipse-3.png'),
          ),
        ),
        SizedBox(height: 18 * fem),
        Container(
          width: 54 * fem,
          height: 45 * fem,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.contain,
            //   // image: AssetImage('assets/page-1/images/ellipse-3.png'),
            // ),
          ),
        ),
        // SizedBox(height: 2101 * fem), // Adjust the spacing here
        // Image.asset(
        //   'assets/page-1/images/ellipse-3.png',
        //   fit: BoxFit.cover,
        // ),
      ],
    );
  }
}
