
import 'dart:convert';

GetAllTrainings getAllTrainingsFromJson(String str) => GetAllTrainings.fromJson(json.decode(str));

String getAllTrainingsToJson(GetAllTrainings data) => json.encode(data.toJson());

class GetAllTrainings {
  List<Datum> data;
  String message;
  bool status;

  GetAllTrainings({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetAllTrainings.fromJson(Map<String, dynamic> json) => GetAllTrainings(
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
  String? title;
  String? videoLink;
  String? description;
  String? position;
  String? url;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.title,
    this.videoLink,
    this.description,
    this.position,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    videoLink: json["video_link"],
    description: json["description"],
    position: json["position"],
    url: json["url"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "video_link": videoLink,
    "description": description,
    "position": position,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
