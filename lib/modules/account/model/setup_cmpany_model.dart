// To parse this JSON data, do
//
//     final getCompanyInfo = getCompanyInfoFromJson(jsonString);

import 'dart:convert';

GetCompanyInfo getCompanyInfoFromJson(String str) =>
    GetCompanyInfo.fromJson(json.decode(str));

String getCompanyInfoToJson(GetCompanyInfo data) => json.encode(data.toJson());

class GetCompanyInfo {
  SetupCompanyData data;
  String message;
  bool status;

  GetCompanyInfo({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetCompanyInfo.fromJson(Map<String, dynamic> json) => GetCompanyInfo(
        data: SetupCompanyData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class SetupCompanyData {
  int? id;
  String userId;
  String title;
  String firstName;
  String lastName;
  String companyName;
  String postCode;
  dynamic lookUp;
  String address;
  String mobile;
  String email;
  String webAddress;
  String companyNumber;
  String vatNumber;
  String sortCode;
  String accountNumber;
  String insurancePolicyNumber;
  String accountantEmailAddress;
  DateTime? createdAt;
  DateTime? updatedAt;

  SetupCompanyData({
    this.id,
    required this.userId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.postCode,
    this.lookUp,
    required this.address,
    required this.mobile,
    required this.email,
    required this.webAddress,
    required this.companyNumber,
    required this.vatNumber,
    required this.sortCode,
    required this.accountNumber,
    required this.insurancePolicyNumber,
    required this.accountantEmailAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory SetupCompanyData.fromJson(Map<String, dynamic> json) =>
      SetupCompanyData(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyName: json["company_name"],
        postCode: json["post_code"],
        lookUp: json["look_up"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        webAddress: json["web_address"],
        companyNumber: json["company_number"],
        vatNumber: json["vat_number"],
        sortCode: json["sort_code"],
        accountNumber: json["account_number"],
        insurancePolicyNumber: json["insurance_policy_number"],
        accountantEmailAddress: json["Accountant_email_address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "company_name": companyName,
        "post_code": postCode,
        // "look_up": lookUp,
        "address": address,
        "mobile": mobile,
        "email": email,
        "web_address": webAddress,
        "company_number": companyNumber,
        "vat_number": vatNumber,
        "sort_code": sortCode,
        "account_number": accountNumber,
        "insurance_policy_number": insurancePolicyNumber,
        "Accountant_email_address": accountantEmailAddress,
      };
}
