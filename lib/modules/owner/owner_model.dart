// To parse this JSON data, do
//
//     final employeeRequestModel = employeeRequestModelFromJson(jsonString);

import 'dart:convert';

EmployeeRequestModel employeeRequestModelFromJson(String str) => EmployeeRequestModel.fromJson(json.decode(str));

String employeeRequestModelToJson(EmployeeRequestModel data) => json.encode(data.toJson());

class EmployeeRequestModel {
    String? status;
    List<Datum>? data;

    EmployeeRequestModel({
        this.status,
        this.data,
    });

    factory EmployeeRequestModel.fromJson(Map<String, dynamic> json) => EmployeeRequestModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? reqId;
    Employee? employee;

    Datum({
        this.reqId,
        this.employee,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        reqId: json["req_id"],
        employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
    );

    Map<String, dynamic> toJson() => {
        "req_id": reqId,
        "employee": employee?.toJson(),
    };
}
class Employee {
    int? id;
    String? name;
    String? email;
    int? role;
    String? phone;
    DateTime? createdAt;
    bool? isActive;

    Employee({
        this.id,
        this.name,
        this.email,
        this.role,
        this.phone,
        this.createdAt,
        this.isActive,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        phone: json["phone"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
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



// To parse this JSON data, do
//
//     final deleteReqResponse = deleteReqResponseFromJson(jsonString);

// import 'dart:convert';

DeleteReqResponse deleteReqResponseFromJson(String str) => DeleteReqResponse.fromJson(json.decode(str));

String deleteReqResponseToJson(DeleteReqResponse data) => json.encode(data.toJson());

class DeleteReqResponse {
    String? status;
    String? message;

    DeleteReqResponse({
        this.status,
        this.message,
    });

    factory DeleteReqResponse.fromJson(Map<String, dynamic> json) => DeleteReqResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}


// To parse this JSON data, do
//
//     final acceptReqResponse = acceptReqResponseFromJson(jsonString);

// import 'dart:convert';

AcceptReqResponse acceptReqResponseFromJson(String str) => AcceptReqResponse.fromJson(json.decode(str));

String acceptReqResponseToJson(AcceptReqResponse data) => json.encode(data.toJson());

class AcceptReqResponse {
    String? status;
    Data? data;

    AcceptReqResponse({
        this.status,
        this.data,
    });

    factory AcceptReqResponse.fromJson(Map<String, dynamic> json) => AcceptReqResponse(
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
    String? email;
    int? role;
    String? phone;
    int? id;
    DateTime? createdAt;
    bool? isActive;

    Data({
        this.name,
        this.email,
        this.role,
        this.phone,
        this.id,
        this.createdAt,
        this.isActive,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
