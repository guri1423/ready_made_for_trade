// To parse this JSON data, do
//
//     final getUserData = getUserDataFromJson(jsonString);

import 'dart:convert';

GetUserData getUserDataFromJson(String str) =>
    GetUserData.fromJson(json.decode(str));

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
  UserData data;
  String message;
  bool status;

  GetUserData({
    required this.data,
    required this.message,
    required this.status,
  });

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
  dynamic emailVerifiedAt;
  dynamic otp;
  String? subscriptionsType;
  String? status;
  String? datafrom;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? currentMonth;
  int? currentMonthPrice;
  List<StatusCount>? statusCounts;

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
    this.subscriptionsType,
    this.status,
    this.datafrom,
    this.currentMonth,
    this.currentMonthPrice,
    this.statusCounts,
  });

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
        subscriptionsType: json["subscriptions_type"],
        status: json["status"],
        datafrom: json["datafrom"],
        currentMonth: json["current_month"],
        currentMonthPrice: json["current_month_price"],
        statusCounts: List<StatusCount>.from(
            json["status_counts"].map((x) => StatusCount.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "business_name": businessName,
        "is_company_registered_with": isCompanyRegisteredWith,
        "company_number": companyNumber,
        "business_trading_date": businessTradingDate!,
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
        "subscriptions_type": subscriptionsType,
        "status": status,
        "datafrom": datafrom,
        "current_month": currentMonth,
        "current_month_price": currentMonthPrice,
        "status_counts":
            List<dynamic>.from(statusCounts!.map((x) => x.toJson())),
      };
}

class StatusCount {
  String? noCount;
  String? title;

  StatusCount({
    this.noCount,
    this.title,
  });

  factory StatusCount.fromJson(Map<String, dynamic> json) => StatusCount(
        noCount: json["no_count"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "no_count": noCount,
        "title": title,
      };
}
