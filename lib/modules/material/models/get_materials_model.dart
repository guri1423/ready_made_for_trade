

import 'dart:convert';

GetAllMaterials getAllMaterialsFromJson(String str) => GetAllMaterials.fromJson(json.decode(str));

String getAllMaterialsToJson(GetAllMaterials data) => json.encode(data.toJson());

class GetAllMaterials {
  List<Datum> data;
  String message;
  bool status;

  GetAllMaterials({
  required  this.data,
  required  this.message,
  required  this.status,
  });

  factory GetAllMaterials.fromJson(Map<String, dynamic> json) => GetAllMaterials(
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
  String? materialName;
  String? materialImage;
  String? url;
  String? filePath;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.materialName,
    this.materialImage,
    this.url,
    this.filePath,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    materialName: json["material_name"],
    materialImage: json["material_image"],
    url: json["url"],
    filePath: json["file_path"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "material_name": materialName,
    "material_image": materialImage,
    "url": url,
    "file_path": filePath,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
