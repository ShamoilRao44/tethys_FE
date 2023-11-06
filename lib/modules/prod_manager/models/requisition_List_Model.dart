// To parse this JSON data, do
//
//     final requisitionListModel = requisitionListModelFromJson(jsonString);

import 'dart:convert';

RequisitionListModel requisitionListModelFromJson(String str) =>
    RequisitionListModel.fromJson(json.decode(str));

String requisitionListModelToJson(RequisitionListModel data) =>
    json.encode(data.toJson());

class RequisitionListModel {
  String? status;
  String? msg;
  List<ReqListDatum>? data;

  RequisitionListModel({
    this.status,
    this.msg,
    this.data,
  });

  factory RequisitionListModel.fromJson(Map<String, dynamic> json) =>
      RequisitionListModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<ReqListDatum>.from(
                json["data"]!.map((x) => ReqListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReqListDatum {
  int? slotId;
  DateTime? reqTime;
  String? remarks;
  dynamic issueTime;
  dynamic issueBy;
  List<Requisition>? requisitions;

  ReqListDatum({
    this.slotId,
    this.reqTime,
    this.remarks,
    this.issueTime,
    this.issueBy,
    this.requisitions,
  });

  factory ReqListDatum.fromJson(Map<String, dynamic> json) => ReqListDatum(
        slotId: json["slot_id"],
        reqTime:
            json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        remarks: json["remarks"],
        issueTime: json["issue_time"],
        issueBy: json["issue_by"],
        requisitions: json["requisitions"] == null
            ? []
            : List<Requisition>.from(
                json["requisitions"]!.map((x) => Requisition.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "req_time": reqTime?.toIso8601String(),
        "remarks": remarks,
        "issue_time": issueTime,
        "issue_by": issueBy,
        "requisitions": requisitions == null
            ? []
            : List<dynamic>.from(requisitions!.map((x) => x.toJson())),
      };
}

class Requisition {
  int? reqId;
  int? qtyReq;
  MatDetails? matDetails;

  Requisition({
    this.reqId,
    this.qtyReq,
    this.matDetails,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) => Requisition(
        reqId: json["req_id"],
        qtyReq: json["qty_req"],
        matDetails: json["mat_details"] == null
            ? null
            : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "qty_req": qtyReq,
        "mat_details": matDetails?.toJson(),
      };
}

class MatDetails {
  String? material;
  int? gNo;
  int? id;
  String? umo;

  MatDetails({
    this.material,
    this.gNo,
    this.id,
    this.umo,
  });

  factory MatDetails.fromJson(Map<String, dynamic> json) => MatDetails(
        material: json["material"],
        gNo: json["g_no"],
        id: json["id"],
        umo: json["umo"],
      );

  Map<String, dynamic> toJson() => {
        "material": material,
        "g_no": gNo,
        "id": id,
        "umo": umo,
      };
}
