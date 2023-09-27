// To parse this JSON data, do
//
//     final materialRequestModel = materialRequestModelFromJson(jsonString);

import 'dart:convert';

MaterialRequestModel materialRequestModelFromJson(String str) =>
    MaterialRequestModel.fromJson(json.decode(str));

String materialRequestModelToJson(MaterialRequestModel data) =>
    json.encode(data.toJson());

class MaterialRequestModel {
  String? status;
  List<Items>? data;

  MaterialRequestModel({
    this.status,
    this.data,
  });

  factory MaterialRequestModel.fromJson(Map<String, dynamic> json) =>
      MaterialRequestModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Items>.from(json["data"]!.map((x) => Items.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Items {
  int? reqId;
  int? reqBy;
  int? qty;
  String? remarks;
  DateTime? reqAt;
  Material? material;

  Items({
    this.reqId,
    this.reqBy,
    this.qty,
    this.remarks,
    this.reqAt,
    this.material,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        reqId: json["req_id"],
        reqBy: json["req_by"],
        qty: json["qty"],
        remarks: json["remarks"],
        reqAt: json["req_at"] == null ? null : DateTime.parse(json["req_at"]),
        material: json["material"] == null
            ? null
            : Material.fromJson(json["material"]),
      );

  Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "req_by": reqBy,
        "qty": qty,
        "remarks": remarks,
        "req_at": reqAt?.toIso8601String(),
        "material": material?.toJson(),
      };
}

class Material {
  int? id;
  String? name;
  int? group;
  String? umo;

  Material({
    this.id,
    this.name,
    this.group,
    this.umo,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json["id"],
        name: json["name"],
        group: json["group"],
        umo: json["umo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "group": group,
        "umo": umo,
      };
}
