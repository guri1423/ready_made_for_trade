
import 'dart:convert';

GetJobData getJobDataFromJson(String str) => GetJobData.fromJson(json.decode(str));

String getJobDataToJson(GetJobData data) => json.encode(data.toJson());

class GetJobData {
  Data? data;
  String? message;
  bool? status;

  GetJobData({
    this.data,
    this.message,
    this.status,
  });

  factory GetJobData.fromJson(Map<String, dynamic> json) => GetJobData(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
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
  DateTime? jobStartFullDate;
  DateTime? jobEndFullDate;
  String? jobStartDate;
  String? jobStartMonth;
  String? jobStartYear;
  String? jobStartTime;
  String? jobEndDate;
  String? jobEndMonth;
  String? jobEndYear;
  String? jobEndTime;
  String? depositAmount;
  String? isJobConfirm;
  dynamic? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? customerName;
  String? userName;
  String? userLogo;
  String? filePath;

  Data({
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
    this.jobStartFullDate,
    this.jobEndFullDate,
    this.jobStartDate,
    this.jobStartMonth,
    this.jobStartYear,
    this.jobStartTime,
    this.jobEndDate,
    this.jobEndMonth,
    this.jobEndYear,
    this.jobEndTime,
    this.depositAmount,
    this.isJobConfirm,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.userName,
    this.userLogo,
    this.filePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    jobStartFullDate: DateTime.parse(json["Job_start_full_date"]),
    jobEndFullDate: DateTime.parse(json["Job_end_full_date"]),
    jobStartDate: json["Job_start_date"],
    jobStartMonth: json["job_start_month"],
    jobStartYear: json["job_start_year"],
    jobStartTime: json["job_start_time"],
    jobEndDate: json["Job_end_date"],
    jobEndMonth: json["job_end_month"],
    jobEndYear: json["job_end_year"],
    jobEndTime: json["job_end_time"],
    depositAmount: json["deposit_amount"],
    isJobConfirm: json["is_job_confirm"],
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
    "Job_start_full_date": jobStartFullDate!.toIso8601String(),
    "Job_end_full_date": jobEndFullDate!.toIso8601String(),
    "Job_start_date": jobStartDate,
    "job_start_month": jobStartMonth,
    "job_start_year": jobStartYear,
    "job_start_time": jobStartTime,
    "Job_end_date": jobEndDate,
    "job_end_month": jobEndMonth,
    "job_end_year": jobEndYear,
    "job_end_time": jobEndTime,
    "deposit_amount": depositAmount,
    "is_job_confirm": isJobConfirm,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "customer_name": customerName,
    "user_name": userName,
    "user_logo": userLogo,
    "file_path": filePath,
  };
}
