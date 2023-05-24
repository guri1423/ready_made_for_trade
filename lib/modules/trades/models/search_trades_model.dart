

import 'dart:convert';

TradeSearchResult tradeSearchResultFromJson(String str) => TradeSearchResult.fromJson(json.decode(str));

String tradeSearchResultToJson(TradeSearchResult data) => json.encode(data.toJson());

class TradeSearchResult {
  List<SearchTradesData> data;
  String message;
  bool status;

  TradeSearchResult({
   required this.data,
   required this.message,
   required this.status,
  });

  factory TradeSearchResult.fromJson(Map<String, dynamic> json) => TradeSearchResult(
    data: List<SearchTradesData>.from(json["data"].map((x) => SearchTradesData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class SearchTradesData {
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
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  SearchTradesData({
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

  factory SearchTradesData.fromJson(Map<String, dynamic> json) => SearchTradesData(
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
