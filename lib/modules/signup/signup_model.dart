// To parse this JSON data, do
//
//     final ownerCreateModel = ownerCreateModelFromJson(jsonString);

import 'dart:convert';

OwnerCreateModel ownerCreateModelFromJson(String str) =>
    OwnerCreateModel.fromJson(json.decode(str));

String ownerCreateModelToJson(OwnerCreateModel data) =>
    json.encode(data.toJson());

class OwnerCreateModel {
  String? name;
  String? phone;
  String? email;
  int? id;
  DateTime? createdAt;
  bool? isActive;

  OwnerCreateModel({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.createdAt,
    this.isActive,
  });

  factory OwnerCreateModel.fromJson(Map<String, dynamic> json) =>
      OwnerCreateModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}
