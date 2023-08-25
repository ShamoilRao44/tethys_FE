// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    String? status;
    Data? data;

    SignUpModel({
        this.status,
        this.data,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    String? name;
    String? phone;
    String? email;
    int? id;
    DateTime? createdAt;
    bool? isActive;

    Data({
        this.name,
        this.phone,
        this.email,
        this.id,
        this.createdAt,
        this.isActive,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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


OtpModel OtpModelFromJson(String str) =>
    OtpModel.fromJson(json.decode(str));
class OtpModel {
    String? status;
    String? otp;

    OtpModel({
        this.status,
        this.otp,
    });

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        status: json["status"],
        otp: json["otp"],
    );


}

