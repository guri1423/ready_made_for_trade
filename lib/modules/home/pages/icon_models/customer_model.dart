

import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) => GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) => json.encode(data.toJson());

class GetCustomerModel {
  List<DatumCustomer> data;
  String message;
  bool status;

  GetCustomerModel({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetCustomerModel.fromJson(Map<String, dynamic> json) => GetCustomerModel(
    data: List<DatumCustomer>.from(json["data"].map((x) => DatumCustomer.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DatumCustomer {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? postCode;
  String? lookUp;
  String? address;
  String? mobileNumber;
  String? cisGeneral;
  String? emailAddress;
  String? userEmail;
  String? userId;
  String? status;
  StatusCounts? statusCounts;

  DatumCustomer({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.postCode,
    this.lookUp,
    this.address,
    this.mobileNumber,
    this.cisGeneral,
    this.emailAddress,
    this.userEmail,
    this.userId,
    this.status,
    this.statusCounts,
  });

  factory DatumCustomer.fromJson(Map<String, dynamic> json) => DatumCustomer(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    postCode: json["post_code"],
    lookUp: json["look_up"],
    address: json["address"],
    mobileNumber: json["mobile_number"],
    cisGeneral: json["CIS_General"],
    emailAddress: json["email_address"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    status: json["status"],
    statusCounts: StatusCounts.fromJson(json["status_counts"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "post_code": postCode,
    "look_up": lookUp,
    "address": address,
    "mobile_number": mobileNumber,
    "CIS_General": cisGeneral,
    "email_address": emailAddress,
    "user_email": userEmail,
    "user_id": userId,
    "status": status,
    "status_counts": statusCounts!.toJson(),
  };
}

class StatusCounts {
  dynamic appointmentSet;
  int? confirmJob;
  dynamic confirmStartDate;
  dynamic createQuotes;
  int? depositPaid;
  int? finalInvoice;
  int? jobComplete;
  int? liveJob;
  int? sendFinalInvoice;

  StatusCounts({
    this.appointmentSet,
    this.confirmJob,
    this.confirmStartDate,
    this.createQuotes,
    this.depositPaid,
    this.finalInvoice,
    this.jobComplete,
    this.liveJob,
    this.sendFinalInvoice,
  });

  factory StatusCounts.fromJson(Map<String, dynamic> json) => StatusCounts(
    appointmentSet: json["Appointment Set"],
    confirmJob: json["Confirm job"],
    confirmStartDate: json["Confirm Start Date"],
    createQuotes: json["Create Quotes"],
    depositPaid: json["Deposit Paid"],
    finalInvoice: json["Final Invoice"],
    jobComplete: json["Job Complete"],
    liveJob: json["Live Job"],
    sendFinalInvoice: json["Send Final Invoice"],
  );

  Map<String, dynamic> toJson() => {
    "Appointment Set": appointmentSet,
    "Confirm job": confirmJob,
    "Confirm Start Date": confirmStartDate,
    "Create Quotes": createQuotes,
    "Deposit Paid": depositPaid,
    "Final Invoice": finalInvoice,
    "Job Complete": jobComplete,
    "Live Job": liveJob,
    "Send Final Invoice": sendFinalInvoice,
  };
}
