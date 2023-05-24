import 'dart:convert';

GetUserData getUserDataFromJson(String str) =>
    GetUserData.fromJson(json.decode(str));

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
  GetUserData({
    required this.data,
    required this.message,
    required this.status,
  });

  UserData data;
  String message;
  bool status;

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        data: UserData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class UserData {
  UserData({
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
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  dynamic? fullName;
  dynamic? email;
  dynamic? businessName;
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
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
