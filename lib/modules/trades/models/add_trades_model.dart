

import 'dart:convert';

class AddTradesModel{



  AddTradesModel({
    required this. title,
    required this.first_name,
    required this.last_name,
    required this.nickname,
    required this.trades,
    required this.mobile_number,
    required this.email_address,
    required this.user_email,
    required this.user_id,
    this.id,



  });

  String? title;
  String? first_name;
  String? last_name;
  String? nickname;
  String? trades;
  String? mobile_number;
  String? email_address;
  String? user_email;
  String? user_id;
  int? id;






  Map<String, dynamic> toJson() => {

    "title": title,
    "first_name": first_name,
    "last_name": last_name,
    "nickname": nickname,
    "trades": trades,
    "mobile_number": mobile_number,
    "email_address": email_address,
    "user_email": user_email,
    "user_id": user_id,
    "id": id



  };




}


PostTradesResponse postTradesResponseFromJson(String str) => PostTradesResponse.fromJson(json.decode(str));

String postTradesResponseToJson(PostTradesResponse data) => json.encode(data.toJson());

class PostTradesResponse {
  String message;
  bool status;

  PostTradesResponse({
   required this.message,
   required this.status,
  });

  factory PostTradesResponse.fromJson(Map<String, dynamic> json) => PostTradesResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
