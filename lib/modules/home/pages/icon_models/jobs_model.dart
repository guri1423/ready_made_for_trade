

import 'dart:convert';

JobsModel jobsModelFromJson(String str) => JobsModel.fromJson(json.decode(str));


class JobsModel {
  JobsModel({
   required this.data,
    required this.message,
    required this.status,
  });

  List<Datum> data;
  String message;
  bool status;

  factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

}

class Datum {
  Datum({
    this.id,
    this.projectTitle,
    this.projectDescription,
    this.materialCost,
    this.labourCost,
    this.vat,
    this.totalPrice,
    this.customerId,
    this.userId,
    this.status,

  });

  int? id;
  String? projectTitle;
  String? projectDescription;
  String? materialCost;
  String? labourCost;
  String? vat;
  String? totalPrice;
  int? customerId;
  int? userId;
  String? status;


  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectTitle: json["project_title"],
    projectDescription: json["project_description"],
    materialCost: json["material_cost"],
    labourCost: json["labour_cost"],
    vat: json["vat"],
    totalPrice: json["total_price"],
    customerId: json["customer_id"],
    userId: json["user_id"],
    status: json["status"],

  );


}
