



import 'dart:convert';

class AddCustomerModel{



  AddCustomerModel({
    required this. title,
    required this.first_name,
    required this.last_name,
    required this.post_code,
    required this.look_up,
    required this.address,
    required this.mobile_number,
    required this.email_address,
    required this.CIS_General,
    required this.user_email,
    required this.user_id,
    required this.status,
    this.id


  });

  String? title;
  String? first_name;
  String? last_name;
  String? post_code;
  String? look_up;
  String? address;
  String? mobile_number;
  String? email_address;
  String? CIS_General;
  String? user_email;
  String? user_id;
  String? status;
  String? id;





  Map<String, dynamic> toJson() => {

    "title": title,
    "first_name": first_name,
    "last_name": last_name,
    "post_code": post_code,
    "look_up": look_up,
    "address": address,
    "mobile_number": mobile_number,
    "email_address": email_address,
    "CIS_General": CIS_General,
    "user_email": user_email,
    "user_id": user_id,
    "status": status,
    'id': id


  };




}




AddCustomerResponse addCustomerResponseFromJson(String str) => AddCustomerResponse.fromJson(json.decode(str));

String addCustomerResponseToJson(AddCustomerResponse data) => json.encode(data.toJson());

class AddCustomerResponse {
  String message;
  bool status;

  AddCustomerResponse({
   required this.message,
   required this.status,
  });

  factory AddCustomerResponse.fromJson(Map<String, dynamic> json) => AddCustomerResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
