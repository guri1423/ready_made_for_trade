import 'dart:convert';

GetChecklist getChecklistFromJson(String str) =>
    GetChecklist.fromJson(json.decode(str));

String getChecklistToJson(GetChecklist data) => json.encode(data.toJson());

class GetChecklist {
  List<Datum> data;
  String message;
  bool status;

  GetChecklist({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetChecklist.fromJson(Map<String, dynamic> json) => GetChecklist(
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
  String? checklistName;
  String? videolink;
  String? position;
  String? status;
  String? description;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.checklistName,
    this.videolink,
    this.position,
    this.status,
    this.description,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    checklistName: json["checklist_name"],
    videolink: json["videolink"],
    position: json["position"],
    status: json["status"],
    description: json["description"],
    url: json["url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "checklist_name": checklistName,
    "videolink": videolink,
    "position": position,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}