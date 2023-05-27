// To parse this JSON data, do
//
//     final getDairyData = getDairyDataFromJson(jsonString);

import 'dart:convert';

GetDairyData getDairyDataFromJson(String str) => GetDairyData.fromJson(json.decode(str));

String getDairyDataToJson(GetDairyData data) => json.encode(data.toJson());

class GetDairyData {
  List<DiaryData> data;
  String message;
  bool status;

  GetDairyData({
  required  this.data,
  required  this.message,
  required  this.status,
  });

  factory GetDairyData.fromJson(Map<String, dynamic> json) => GetDairyData(
    data: List<DiaryData>.from(json["data"].map((x) => DiaryData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DiaryData {
  int? id;
  String? userId;
  String? customerId;
  String? jobId;
  String? appointmentId;
  String? category;
  String? projectName;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? customerName;
  String? userName;

  DiaryData({
    this.id,
    this.userId,
    this.customerId,
    this.jobId,
    this.appointmentId,
    this.category,
    this.projectName,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.userName,
  });

  factory DiaryData.fromJson(Map<String, dynamic> json) => DiaryData(
    id: json["id"],
    userId: json["user_id"],
    customerId: json["customer_id"],
    jobId: json["job_id"],
    appointmentId: json["appointment_id"],
    category: json["category"],
    projectName: json["project_name"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customerName: json["customer_name"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "customer_id": customerId,
    "job_id": jobId,
    "appointment_id": appointmentId,
    "category": category,
    "project_name": projectName,
    "date": date!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "customer_name": customerName,
    "user_name": userName,
  };
}
