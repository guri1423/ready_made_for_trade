

import 'dart:convert';

GetJobList getJobListFromJson(String str) => GetJobList.fromJson(json.decode(str));

String getJobListToJson(GetJobList data) => json.encode(data.toJson());

class GetJobList {
  List<String> data;
  String message;
  bool status;

  GetJobList({
  required  this.data,
  required  this.message,
  required  this.status,
  });

  factory GetJobList.fromJson(Map<String, dynamic> json) => GetJobList(
    data: List<String>.from(json["data"].map((x) => x)),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x)),
    "message": message,
    "status": status,
  };
}
