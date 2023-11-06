import 'dart:convert';

ReturnMaterialModel returnMaterialModelFromJson(String str) =>
    ReturnMaterialModel.fromJson(json.decode(str));

String returnMaterialModelToJson(ReturnMaterialModel data) =>
    json.encode(data.toJson());

class ReturnMaterialModel {
  String? status;
  String? msg;
  Data? data;

  ReturnMaterialModel({
    this.status,
    this.msg,
    this.data,
  });

  factory ReturnMaterialModel.fromJson(Map<String, dynamic> json) =>
      ReturnMaterialModel(
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
  int? slotId;
  DateTime? retTime;
  String? remarks;
  bool? recieved;
  RetBy? retBy;
  List<MaterialsReturn>? materialsReturn;

  Data({
    this.slotId,
    this.retTime,
    this.remarks,
    this.recieved,
    this.retBy,
    this.materialsReturn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        slotId: json["slot_id"],
        retTime:
            json["ret_time"] == null ? null : DateTime.parse(json["ret_time"]),
        remarks: json["remarks"],
        recieved: json["recieved"],
        retBy: json["ret_by"] == null ? null : RetBy.fromJson(json["ret_by"]),
        materialsReturn: json["materials_return"] == null
            ? []
            : List<MaterialsReturn>.from(json["materials_return"]!
                .map((x) => MaterialsReturn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId,
        "ret_time": retTime?.toIso8601String(),
        "remarks": remarks,
        "recieved": recieved,
        "ret_by": retBy?.toJson(),
        "materials_return": materialsReturn == null
            ? []
            : List<dynamic>.from(materialsReturn!.map((x) => x.toJson())),
      };
}

class MaterialsReturn {
  int? retId;
  int? qtyRet;
  MatDetails? matDetails;

  MaterialsReturn({
    this.retId,
    this.qtyRet,
    this.matDetails,
  });

  factory MaterialsReturn.fromJson(Map<String, dynamic> json) =>
      MaterialsReturn(
        retId: json["ret_id"],
        qtyRet: json["qty_ret"],
        matDetails: json["mat_details"] == null
            ? null
            : MatDetails.fromJson(json["mat_details"]),
      );

  Map<String, dynamic> toJson() => {
        "ret_id": retId,
        "qty_ret": qtyRet,
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

class RetBy {
  int? id;
  String? name;
  String? email;
  int? role;
  String? phone;
  DateTime? createdAt;
  bool? isActive;

  RetBy({
    this.id,
    this.name,
    this.email,
    this.role,
    this.phone,
    this.createdAt,
    this.isActive,
  });

  factory RetBy.fromJson(Map<String, dynamic> json) => RetBy(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}
