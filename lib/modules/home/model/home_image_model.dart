// To parse this JSON data, do
//
//     final homeImage = homeImageFromJson(jsonString);

import 'dart:convert';

HomeImage homeImageFromJson(String str) => HomeImage.fromJson(json.decode(str));

String homeImageToJson(HomeImage data) => json.encode(data.toJson());

class HomeImage {
  Data data;
  String message;
  bool status;

  HomeImage({
    required this.data,
    required this.message,
    required this.status,
  });

  factory HomeImage.fromJson(Map<String, dynamic> json) => HomeImage(
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
  int id;
  String url;
  String image;
  String filePath;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.url,
    required this.image,
    required this.filePath,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    url: json["url"],
    image: json["image"],
    filePath: json["file_path"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "image": image,
    "file_path": filePath,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
