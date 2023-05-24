
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  Data data;
  String message;
  bool status;

  LoginResponseModel({
  required  this.data,
  required  this.message,
   required this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
  int? id;
  String? fullName;
  String? email;
  String? businessName;
  String? isCompanyRegisteredWith;
  String? companyNumber;
  String? businessTradingDate;
  String? logo;
  String? filePath;
  String? bussniessBankAccount;
  String? contact;
  String? website;
  String? trade;
  String? address;
  String? mobile;
  String? membershipType;
  dynamic? emailVerifiedAt;
  dynamic? otp;
  String? status;
  String? datafrom;


  Data({
    this.id,
    this.fullName,
    this.email,
    this.businessName,
    this.isCompanyRegisteredWith,
    this.companyNumber,
    this.businessTradingDate,
    this.logo,
    this.filePath,
    this.bussniessBankAccount,
    this.contact,
    this.website,
    this.trade,
    this.address,
    this.mobile,
    this.membershipType,
    this.emailVerifiedAt,
    this.otp,
    this.status,
    this.datafrom,

  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullName: json["full_name"],
    email: json["email"],
    businessName: json["business_name"],
    isCompanyRegisteredWith: json["is_company_registered_with"],
    companyNumber: json["company_number"],
    businessTradingDate: json["business_trading_date"],
    logo: json["logo"],
    filePath: json["file_path"],
    bussniessBankAccount: json["bussniess_bank_account"],
    contact: json["contact"],
    website: json["website"],
    trade: json["trade"],
    address: json["address"],
    mobile: json["mobile"],
    membershipType: json["membership_type"],
    emailVerifiedAt: json["email_verified_at"],
    otp: json["otp"],
    status: json["status"],
    datafrom: json["datafrom"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "email": email,
    "business_name": businessName,
    "is_company_registered_with": isCompanyRegisteredWith,
    "company_number": companyNumber,
    "business_trading_date": businessTradingDate,
    "logo": logo,
    "file_path": filePath,
    "bussniess_bank_account": bussniessBankAccount,
    "contact": contact,
    "website": website,
    "trade": trade,
    "address": address,
    "mobile": mobile,
    "membership_type": membershipType,
    "email_verified_at": emailVerifiedAt,
    "otp": otp,
    "status": status,
    "datafrom": datafrom,

  };
}
