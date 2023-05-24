// To parse this JSON data, do
//
//     final getGalleryImages = getGalleryImagesFromJson(jsonString);

import 'dart:convert';

GetGalleryImages getGalleryImagesFromJson(String str) => GetGalleryImages.fromJson(json.decode(str));

String getGalleryImagesToJson(GetGalleryImages data) => json.encode(data.toJson());

class GetGalleryImages {
  List<Datum> data;
  String message;
  bool status;

  GetGalleryImages({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetGalleryImages.fromJson(Map<String, dynamic> json) => GetGalleryImages(
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
  dynamic? customerId;
  String? userId;
  String? image;
  String? filePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.customerId,
    this.userId,
    this.image,
    this.filePath,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerId: json["customer_id"],
    userId: json["user_id"],
    image: json["image"],
    filePath: json["file_path"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "user_id": userId,
    "image": image,
    "file_path": filePath,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
