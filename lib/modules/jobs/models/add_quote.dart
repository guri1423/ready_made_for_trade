import 'dart:convert';

class AddQuoteModel {
  AddQuoteModel({
    required this.userId,
    required this.customerId,
    required this.materialCost,
    required this.labourCost,
    required this.vat,
    required this.projectId,
    required this.projectTitle,
    required this.projectDescription,
    required this.jobId,
    required this.status
  });

  int? userId;
  int? customerId;
  String? materialCost;
  String? labourCost;
  int? vat;
  int? projectId;
  String? projectTitle;
  String? projectDescription;
  int? jobId;
  String? status;

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "customer_id": customerId,
        "material_cost": materialCost,
        "labour_cost": labourCost,
        "vat": vat,
        "project_id": projectId,
        "project_title": projectTitle,
        "project_description": projectDescription,
        "job_id": jobId,
        "status":status
      };
}

AddQuoteResponse addQuoteResponseFromJson(String str) =>
    AddQuoteResponse.fromJson(json.decode(str));

String addQuoteResponseToJson(AddQuoteResponse data) =>
    json.encode(data.toJson());

class AddQuoteResponse {
  String? message;
  int? jobid;
  bool? status;

  AddQuoteResponse({
    this.message,
    this.jobid,
    this.status,
  });

  factory AddQuoteResponse.fromJson(Map<String, dynamic> json) =>
      AddQuoteResponse(
        message: json["message"],
        jobid: json["jobid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "jobid": jobid,
        "status": status,
      };
}
