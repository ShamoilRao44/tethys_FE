import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/owner_vm.dart';

import '../../../../resources/app_colors.dart';

class EmplRequests extends StatelessWidget {
  EmplRequests({super.key});

  OwnerHomeVM controll = Get.put(OwnerHomeVM());

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
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 490,
                  child: GetX<OwnerHomeVM>(builder: (ctrl) {
                    return ctrl.empRequests.isEmpty
                        ? SizedBox(
                            height: 10, child: CircularProgressIndicator())
                        : ListView(
                            children: ctrl.empRequests.map((req) {
                              return ListTile(
                                title: Text('${req.employee!.name}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        debugPrint('accept');
                                        ctrl.acceptRequest(req.reqId!);
                                      },
                                      child: Text('Accept'),
                                    ),
                                    SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        debugPrint('denied');
                                        ctrl.acceptRequest(req.reqId!);
                                      },
                                      child: Text('Deny'),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                  })),
            ],
          )),
    );
  }
}
