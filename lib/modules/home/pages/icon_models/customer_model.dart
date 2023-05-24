



import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) => GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) => json.encode(data.toJson());

class GetCustomerModel {
  GetCustomerModel({
    this.data,
    this.message,
    this.status,
  });

  List<DatumCustomer>? data;
  String? message;
  bool? status;

  factory GetCustomerModel.fromJson(Map<String, dynamic> json) => GetCustomerModel(
    data: List<DatumCustomer>.from(json["data"].map((x) => DatumCustomer.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class DatumCustomer {
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

  });

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

  };
}
