// To parse this JSON data, do
//
//     final LoginModel = LoginModelFromJson(jsonString);

import 'dart:convert';

LoginModel LoginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String? accessToken;
    String? tokenType;
    String? status;
    User? user;

    LoginModel({
        this.accessToken,
        this.tokenType,
        this.status,
        this.user,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        status: json["status"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "status": status,
        "user": user?.toJson(),
    };
}

class User {
    String? name;
    String? email;
    int? role;
    String? phone;
    int? id;
    DateTime? createdAt;
    bool? isActive;

    User({
        this.name,
        this.email,
        this.role,
        this.phone,
        this.id,
        this.createdAt,
        this.isActive,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "role": role,
        "phone": phone,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
    };
}
