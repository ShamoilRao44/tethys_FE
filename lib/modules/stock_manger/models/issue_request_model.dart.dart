// To parse this JSON data, do
//
//     final issueRequestModel = issueRequestModelFromJson(jsonString);

import 'dart:convert';

IssueRequestModel issueRequestModelFromJson(String str) =>
    IssueRequestModel.fromJson(json.decode(str));

String issueRequestModelToJson(IssueRequestModel data) =>
    json.encode(data.toJson());

class IssueRequestModel {
  String? status;
  String? msg;
  Data? data;

  IssueRequestModel({
    this.status,
    this.msg,
    this.data,
  });

  factory IssueRequestModel.fromJson(Map<String, dynamic> json) =>
      IssueRequestModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  String? remarks;
  DateTime? reqTime;
  int? issuedBy;
  bool? issueStatus;
  int? slotId;
  int? reqBy;
  DateTime? issueTime;

  Data({
    this.remarks,
    this.reqTime,
    this.issuedBy,
    this.issueStatus,
    this.slotId,
    this.reqBy,
    this.issueTime,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        remarks: json["remarks"],
        reqTime:
            json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        issuedBy: json["issued_by"],
        issueStatus: json["issue_status"],
        slotId: json["slot_id"],
        reqBy: json["req_by"],
        issueTime: json["issue_time"] == null
            ? null
            : DateTime.parse(json["issue_time"]),
      );

  Map<String, dynamic> toJson() => {
        "remarks": remarks,
        "req_time": reqTime?.toIso8601String(),
        "issued_by": issuedBy,
        "issue_status": issueStatus,
        "slot_id": slotId,
        "req_by": reqBy,
        "issue_time": issueTime?.toIso8601String(),
      };
}
