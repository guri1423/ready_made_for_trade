// To parse this JSON data, do
//
//     final getJobData = getJobDataFromJson(jsonString);

import 'dart:convert';

GetJobData getJobDataFromJson(String str) => GetJobData.fromJson(json.decode(str));

String getJobDataToJson(GetJobData data) => json.encode(data.toJson());

class GetJobData {
  JobData data;
  String message;
  bool status;

  GetJobData({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetJobData.fromJson(Map<String, dynamic> json) => GetJobData(
    data: JobData.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class JobData {
  int? id;
  String? appointmentId;
  String? quoteId;
  dynamic projectId;
  String? projectTitle;
  String? projectDescription;
  String? materialCost;
  String? labourCost;
  String? vat;
  String? isVat;
  String? totalPrice;
  dynamic totalIncVat;
  String? customerId;
  String? userId;
  dynamic jobStartFullDate;
  dynamic jobEndFullDate;
  dynamic jobStartDate;
  dynamic jobStartMonth;
  dynamic jobStartYear;
  dynamic jobEndDate;
  dynamic jobEndMonth;
  dynamic jobEndYear;
  dynamic jobStartHourse;
  dynamic jobStartMinutes;
  dynamic jobEndHourse;
  dynamic jobEndMinutes;
  dynamic depositAmount;
  String? isJobConfirm;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? customerName;
  String? userName;
  String? userLogo;
  String? filePath;
  String? address;

  JobData({
    this.id,
    this.appointmentId,
    this.quoteId,
    this.projectId,
    this.projectTitle,
    this.projectDescription,
    this.materialCost,
    this.labourCost,
    this.vat,
    this.isVat,
    this.totalPrice,
    this.totalIncVat,
    this.customerId,
    this.userId,
    this.jobStartFullDate,
    this.jobEndFullDate,
    this.jobStartDate,
    this.jobStartMonth,
    this.jobStartYear,
    this.jobEndDate,
    this.jobEndMonth,
    this.jobEndYear,
    this.jobStartHourse,
    this.jobStartMinutes,
    this.jobEndHourse,
    this.jobEndMinutes,
    this.depositAmount,
    this.isJobConfirm,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.userName,
    this.userLogo,
    this.filePath,
    this.address,
  });

  factory JobData.fromJson(Map<String, dynamic> json) => JobData(
    id: json["id"],
    appointmentId: json["appointment_id"],
    quoteId: json["quote_id"],
    projectId: json["project_id"],
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    materialCost: json["material_cost"],
    labourCost: json["labour_cost"],
    vat: json["vat"],
    isVat: json["is_vat"],
    totalPrice: json["total_price"],
    totalIncVat: json["total_inc_vat"],
    customerId: json["customer_id"],
    userId: json["user_id"],
    jobStartFullDate: json["Job_start_full_date"],
    jobEndFullDate: json["Job_end_full_date"],
    jobStartDate: json["Job_start_date"],
    jobStartMonth: json["job_start_month"],
    jobStartYear: json["job_start_year"],
    jobEndDate: json["Job_end_date"],
    jobEndMonth: json["job_end_month"],
    jobEndYear: json["job_end_year"],
    jobStartHourse: json["job_start_hourse"],
    jobStartMinutes: json["job_start_minutes"],
    jobEndHourse: json["job_end_hourse"],
    jobEndMinutes: json["job_end_minutes"],
    depositAmount: json["deposit_amount"],
    isJobConfirm: json["is_job_confirm"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    customerName: json["customer_name"],
    userName: json["user_name"],
    userLogo: json["user_logo"],
    filePath: json["file_path"],
    address: json["address"],
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
    "is_vat": isVat,
    "total_price": totalPrice,
    "total_inc_vat": totalIncVat,
    "customer_id": customerId,
    "user_id": userId,
    "Job_start_full_date": jobStartFullDate,
    "Job_end_full_date": jobEndFullDate,
    "Job_start_date": jobStartDate,
    "job_start_month": jobStartMonth,
    "job_start_year": jobStartYear,
    "Job_end_date": jobEndDate,
    "job_end_month": jobEndMonth,
    "job_end_year": jobEndYear,
    "job_start_hourse": jobStartHourse,
    "job_start_minutes": jobStartMinutes,
    "job_end_hourse": jobEndHourse,
    "job_end_minutes": jobEndMinutes,
    "deposit_amount": depositAmount,
    "is_job_confirm": isJobConfirm,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "customer_name": customerName,
    "user_name": userName,
    "user_logo": userLogo,
    "file_path": filePath,
    "address": address,
  };
}
