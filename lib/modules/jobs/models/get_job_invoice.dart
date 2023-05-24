// To parse this JSON data, do
//
//     final getJobInvoiceData = getJobInvoiceDataFromJson(jsonString);

import 'dart:convert';

GetJobInvoiceData getJobInvoiceDataFromJson(String str) => GetJobInvoiceData.fromJson(json.decode(str));

String getJobInvoiceDataToJson(GetJobInvoiceData data) => json.encode(data.toJson());

class GetJobInvoiceData {
  JobInvoiceData? data;
  String? message;
  bool? status;

  GetJobInvoiceData({
    this.data,
    this.message,
    this.status,
  });

  factory GetJobInvoiceData.fromJson(Map<String, dynamic> json) => GetJobInvoiceData(
    data: JobInvoiceData.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "status": status,
  };
}

class JobInvoiceData {
  int? id;
  String? appointmentId;
  String? quoteId;
  dynamic? projectId;
  String? projectTitle;
  String? projectDescription;
  String? materialCost;
  String? labourCost;
  String? vat;
  String? totalPrice;
  String? customerId;
  String? userId;
  dynamic? jodStartDate;
  dynamic? jodEndDate;
  dynamic? depositAmount;
  dynamic? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? customerName;
  String? userName;
  String? userLogo;
  String? filePath;

  JobInvoiceData({
    this.id,
    this.appointmentId,
    this.quoteId,
    this.projectId,
    this.projectTitle,
    this.projectDescription,
    this.materialCost,
    this.labourCost,
    this.vat,
    this.totalPrice,
    this.customerId,
    this.userId,
    this.jodStartDate,
    this.jodEndDate,
    this.depositAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.userName,
    this.userLogo,
    this.filePath,
  });

  factory JobInvoiceData.fromJson(Map<String, dynamic> json) => JobInvoiceData(
    id: json["id"],
    appointmentId: json["appointment_id"],
    quoteId: json["quote_id"],
    projectId: json["project_id"],
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    materialCost: json["material_cost"],
    labourCost: json["labour_cost"],
    vat: json["vat"],
    totalPrice: json["total_price"],
    customerId: json["customer_id"],
    userId: json["user_id"],
    jodStartDate: json["Jod_start_date"],
    jodEndDate: json["Jod_end_date"],
    depositAmount: json["deposit_amount"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customerName: json["customer_name"],
    userName: json["user_name"],
    userLogo: json["user_logo"],
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_id": appointmentId,
    "quote_id": quoteId,
    "project_id": projectId,
    "project_title": projectTitle,
    "project_description": projectDescription,
    "material_cost": materialCost,
    "labour_cost": labourCost,
    "vat": vat,
    "total_price": totalPrice,
    "customer_id": customerId,
    "user_id": userId,
    "job_start_date": jodStartDate,
    "job_end_date": jodEndDate,
    "deposit_amount": depositAmount,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "customer_name": customerName,
    "user_name": userName,
    "user_logo": userLogo,
    "file_path": filePath,
  };
}
