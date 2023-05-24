



import 'dart:convert';

AddProjectResponse addProjectResponseFromJson(String str) => AddProjectResponse.fromJson(json.decode(str));

String addProjectResponseToJson(AddProjectResponse data) => json.encode(data.toJson());

class AddProjectResponse {
  String? message;
  bool? status;

  AddProjectResponse({
    this.message,
    this.status,
  });

  factory AddProjectResponse.fromJson(Map<String, dynamic> json) => AddProjectResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
