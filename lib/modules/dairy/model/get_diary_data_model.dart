// To parse this JSON data, do
//
//     final getDairyData = getDairyDataFromJson(jsonString);

import 'dart:convert';

GetDairyData getDairyDataFromJson(String str) => GetDairyData.fromJson(json.decode(str));

String getDairyDataToJson(GetDairyData data) => json.encode(data.toJson());

class GetDairyData {
  List<DairyData> data;
  String message;
  bool status;

  GetDairyData({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetDairyData.fromJson(Map<String, dynamic> json) => GetDairyData(
    data: List<DairyData>.from(json["data"].map((x) => DairyData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DairyData {
  int? userId;
  int? customerId;
  int? date;
  int? month;
  int? year;
  String? minutes;
  String? hours;
  String? projectTitle;
  String? projectDescription;
  int? projectId;
  String? status;
  String? customerName;

  DairyData({
    this.userId,
    this.customerId,
    this.date,
    this.month,
    this.year,
    this.minutes,
    this.hours,
    this.projectTitle,
    this.projectDescription,
    this.projectId,
    this.status,
    this.customerName,
  });

  factory DairyData.fromJson(Map<String, dynamic> json) => DairyData(
    userId: json["user_id"],
    customerId: json["customer_id"],
    date: json["date"],
    month: json["month"],
    year: json["year"],
    minutes: json["minutes"],
    hours: json["hours"],
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    projectId: json["project_id"],
    status: json["status"],
    customerName: json["customer_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "customer_id": customerId,
    "date": date,
    "month": month,
    "year": year,
    "minutes": minutes,
    "hours": hours,
    "project_title": projectTitle,
    "project_description": projectDescription,
    "project_id": projectId,
    "status": status,
    "customer_name": customerName,
  };
}
