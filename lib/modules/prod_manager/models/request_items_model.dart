import 'dart:convert';

RequestItemsModel requestItemsModelFromJson(String str) =>
    RequestItemsModel.fromJson(json.decode(str));

String requestItemsModelToJson(RequestItemsModel data) =>
    json.encode(data.toJson());

class RequestItemsModel {
  String? status;
  List<Request>? data;

  RequestItemsModel({
    this.status,
    this.data,
  });

  factory RequestItemsModel.fromJson(Map<String, dynamic> json) =>
      RequestItemsModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Request>.from(json["data"]!.map((x) => Request.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Request {
  int? qtyReq;
  int? reqId;
  String? remarks;
  DateTime? reqTime;
  int? mId;
  int? reqBy;

  Request({
    this.qtyReq,
    this.reqId,
    this.remarks,
    this.reqTime,
    this.mId,
    this.reqBy,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        qtyReq: json["qty_req"],
        reqId: json["req_id"],
        remarks: json["remarks"],
        reqTime:
            json["req_time"] == null ? null : DateTime.parse(json["req_time"]),
        mId: json["m_id"],
        reqBy: json["req_by"],
      );

  Map<String, dynamic> toJson() => {
        "qty_req": qtyReq,
        "req_id": reqId,
        "remarks": remarks,
        "req_time": reqTime?.toIso8601String(),
        "m_id": mId,
        "req_by": reqBy,
      };
}

