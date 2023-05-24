

// To parse this JSON data, do
//
//     final getAllTrades = getAllTradesFromJson(jsonString);

import 'dart:convert';

GetAllTrades getAllTradesFromJson(String str) => GetAllTrades.fromJson(json.decode(str));

String getAllTradesToJson(GetAllTrades data) => json.encode(data.toJson());

class GetAllTrades {
  List<DatumTrade> data;
  String message;
  bool status;

  GetAllTrades({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetAllTrades.fromJson(Map<String, dynamic> json) => GetAllTrades(
    data: List<DatumTrade>.from(json["data"].map((x) => DatumTrade.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DatumTrade {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? nickname;
  String? trades;
  String? mobileNumber;
  String? emailAddress;
  String? userEmail;
  String? userId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  DatumTrade({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.nickname,
    this.trades,
    this.mobileNumber,
    this.emailAddress,
    this.userEmail,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DatumTrade.fromJson(Map<String, dynamic> json) => DatumTrade(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    nickname: json["nickname"],
    trades: json["trades"],
    mobileNumber: json["mobile_number"],
    emailAddress: json["email_address"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "nickname": nickname,
    "trades": trades,
    "mobile_number": mobileNumber,
    "email_address": emailAddress,
    "user_email": userEmail,
    "user_id": userId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
