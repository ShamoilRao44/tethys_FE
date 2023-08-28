import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tethys/modules/owner/owner_model.dart' as own;
import 'package:tethys/modules/owner/owner_repo/owner_repoimpl.dart';

class OwnerHomeVM extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debugPrint('called');
    getRequests();
  }

  OwnerRepoImp ownerRepoImp = OwnerRepoImp();
  var empRequests = <own.Datum>[].obs;

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
    data['req_id'] = id.toString();
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
    await ownerRepoImp.DeleteReq(data).then((res) {
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
    // TODO: implement dispose
    super.dispose();
    empRequests.clear();
  }
}
