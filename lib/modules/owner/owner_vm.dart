import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/owner_model.dart' as own;
import 'package:tethys/modules/owner/owner_repo/owner_repoimpl.dart';
import 'package:tethys/modules/owner/views/empl_requests.dart';
import 'package:tethys/modules/owner/views/owner_dashboard_view.dart';
import 'package:tethys/modules/owner/views/user_list_screen.dart';

class OwnerHomeVM extends GetxController {
  OwnerRepoImp ownerRepoImp = OwnerRepoImp();
  var empRequests = <own.Datum>[].obs;
  Widget? child = OwnerDashboard();
  RxInt indx = 0.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint('called');
    getRequests();
  }

  void onTabChange(int index) {
    indx.value = index;

    switch (indx.value) {
      case 0:
        child = OwnerDashboard();
        break;
      case 1:
        child = UserListScreen();
        break;
      case 2:
        child = EmplRequests();
        break;
    }

    update();
  }

  Future<void> getRequests() async {
    empRequests.clear();

    await ownerRepoImp.getEmpReq().then((res) {
      if (res.status == '200') {
        for (var request in res.data!) {
          empRequests.add(request);
          update();
        }
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  Future<void> acceptRequest(int id) async {
    //implement permiting request api here and pass id as 'req_id'
    var data = {};
    data['req_id'] = id;
    debugPrint(data.toString());
    await ownerRepoImp.postEmpReq(data).then((val) {
      if (val.status == '200') {
        debugPrint('success');
        getRequests();
      } else {
        debugPrint('failed');
      }
    }).onError((error, stackTrace) => null);
  }

  Future<void> deleteRequest(int id) async {
    //implement deleteing request api here and pass id as 'req_id'
    var data = {};
    data['req_id'] = id.toString();
    debugPrint(data.toString());
    await ownerRepoImp.deleteReq(data).then((res) {
      if (res.status == '200') {
        debugPrint('success');
        getRequests();
      } else {
        debugPrint('failed');
      }
    }).onError((error, stackTrace) => null);
    // var data2 = {
    //   "req_id" : id.toString()
    // }
  }

  @override
  void dispose() {
    super.dispose();
    empRequests.clear();
  }
}
