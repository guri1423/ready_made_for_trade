// To parse this JSON data, do
//
//     final getEssentialsData = getEssentialsDataFromJson(jsonString);

import 'dart:convert';

GetEssentialsData getEssentialsDataFromJson(String str) => GetEssentialsData.fromJson(json.decode(str));

String getEssentialsDataToJson(GetEssentialsData data) => json.encode(data.toJson());

class GetEssentialsData {
  List<Datum> data;
  String message;
  bool status;

  GetEssentialsData({
  required  this.data,
  required  this.message,
  required  this.status,
  });

  factory GetEssentialsData.fromJson(Map<String, dynamic> json) => GetEssentialsData(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Datum {
  int? id;
  String? name;
  String? image;
  String? link;
  String? description;
  String? filePath;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.image,
    this.link,
    this.description,
    this.filePath,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    link: json["link"],
    description: json["description"],
    filePath: json["file_path"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "link": link,
    "description": description,
    "file_path": filePath,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
