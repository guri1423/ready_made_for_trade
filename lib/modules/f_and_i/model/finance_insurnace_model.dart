

import 'dart:convert';

GetFinanceAndInsurance getFinanceAndInsuranceFromJson(String str) => GetFinanceAndInsurance.fromJson(json.decode(str));

String getFinanceAndInsuranceToJson(GetFinanceAndInsurance data) => json.encode(data.toJson());

class GetFinanceAndInsurance {
  List<FinanceAndInsuranceData> data;
  String message;
  bool status;

  GetFinanceAndInsurance({
   required this.data,
    required this.message,
    required this.status,
  });

  factory GetFinanceAndInsurance.fromJson(Map<String, dynamic> json) => GetFinanceAndInsurance(
    data: List<FinanceAndInsuranceData>.from(json["data"].map((x) => FinanceAndInsuranceData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class FinanceAndInsuranceData {
  int id;
  String category;
  String title;
  String image;
  String description;
  String moreDetails;
  String link;
  String filePath;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  FinanceAndInsuranceData({
    required  this.id,
    required this.category,
    required this.title,
    required  this.image,
    required  this.description,
    required  this.moreDetails,
    required  this.link,
    required this.filePath,
    required this.status,
    required  this.createdAt,
    required  this.updatedAt,
  });

  factory FinanceAndInsuranceData.fromJson(Map<String, dynamic> json) => FinanceAndInsuranceData(
    id: json["id"],
    category: json["category"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    moreDetails: json["more_details"],
    link: json["link"],
    filePath: json["file_path"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "title": title,
    "image": image,
    "description": description,
    "more_details": moreDetails,
    "link": link,
    "file_path": filePath,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
