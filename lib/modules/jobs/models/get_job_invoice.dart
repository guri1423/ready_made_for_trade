import 'dart:convert';

GetJobInvoiceData getJobInvoiceDataFromJson(String str) => GetJobInvoiceData.fromJson(json.decode(str));

String getJobInvoiceDataToJson(GetJobInvoiceData data) => json.encode(data.toJson());

class GetJobInvoiceData {
  Data data;
  String message;
  bool status;

  GetJobInvoiceData({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetJobInvoiceData.fromJson(Map<String, dynamic> json) => GetJobInvoiceData(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}

class Data {
  int id;
  String appointmentId;
  String quoteId;
  dynamic projectId;
  String projectTitle;
  String projectDescription;
  String materialCost;
  String labourCost;
  String vat;
  String isVat;
  String totalPrice;
  String totalIncVat;
  String customerId;
  String userId;
  dynamic jobStartFullDate;
  dynamic jobEndFullDate;
  dynamic jobStartDate;
  dynamic jobEndDate;
  dynamic jobStartTime;
  dynamic jobEndTime;
  dynamic depositAmount;
  dynamic requestDepositAmount;
  dynamic depositAmountDate;
  String isJobConfirm;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String quoteTerms;
  String invoiceTerms;
  String customerName;
  String userName;
  String userLogo;
  String filePath;
  String userAddress;
  String customerAddress;
  double remaining;

  Data({
    required this.id,
    required this.appointmentId,
    required this.quoteId,
    this.projectId,
    required this.projectTitle,
    required this.projectDescription,
    required this.materialCost,
    required this.labourCost,
    required this.vat,
    required this.isVat,
    required this.totalPrice,
    required this.totalIncVat,
    required this.customerId,
    required this.userId,
    this.jobStartFullDate,
    this.jobEndFullDate,
    this.jobStartDate,
    this.jobEndDate,
    this.jobStartTime,
    this.jobEndTime,
    this.depositAmount,
    this.requestDepositAmount,
    this.depositAmountDate,
    required this.isJobConfirm,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.quoteTerms,
    required this.invoiceTerms,
    required this.customerName,
    required this.userName,
    required this.userLogo,
    required this.filePath,
    required this.userAddress,
    required this.customerAddress,
    required this.remaining,
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
    isVat: json["is_vat"],
    totalPrice: json["total_price"],
    totalIncVat: json["total_inc_vat"],
    customerId: json["customer_id"],
    userId: json["user_id"],
    jobStartFullDate: json["Job_start_full_date"],
    jobEndFullDate: json["Job_end_full_date"],
    jobStartDate: json["Job_start_date"],
    jobEndDate: json["Job_end_date"],
    jobStartTime: json["job_start_time"],
    jobEndTime: json["job_end_time"],
    depositAmount: json["deposit_amount"],
    requestDepositAmount: json["request_deposit_amount"],
    depositAmountDate: json["deposit_amount_date"],
    isJobConfirm: json["is_job_confirm"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    quoteTerms: json["quote_terms"],
    invoiceTerms: json["invoice_terms"],
    customerName: json["customer_name"],
    userName: json["user_name"],
    userLogo: json["user_logo"],
    filePath: json["file_path"],
    userAddress: json["user_address"],
    customerAddress: json["customer_address"],
    remaining: json["Remaining"]?.toDouble(),
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
    "Job_end_date": jobEndDate,
    "job_start_time": jobStartTime,
    "job_end_time": jobEndTime,
    "deposit_amount": depositAmount,
    "request_deposit_amount": requestDepositAmount,
    "deposit_amount_date": depositAmountDate,
    "is_job_confirm": isJobConfirm,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "quote_terms": quoteTerms,
    "invoice_terms": invoiceTerms,
    "customer_name": customerName,
    "user_name": userName,
    "user_logo": userLogo,
    "file_path": filePath,
    "user_address": userAddress,
    "customer_address": customerAddress,
    "Remaining": remaining,
  };
}
