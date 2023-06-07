


import 'dart:convert';

AddDataResponse addDataResponseFromJson(String str) => AddDataResponse.fromJson(json.decode(str));

String addDataResponseToJson(AddDataResponse data) => json.encode(data.toJson());

class AddDataResponse {
  String message;
  bool status;

  AddDataResponse({
    required this.message,
    required this.status,
  });

  factory AddDataResponse.fromJson(Map<String, dynamic> json) => AddDataResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}