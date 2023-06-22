import 'dart:convert';
GetWebsite getWebsiteFromJson(String str) => GetWebsite.fromJson(json.decode(str));
String getWebsiteToJson(GetWebsite data) => json.encode(data.toJson());
class GetWebsite {
  List<Data> data;
  String message;
  bool status;
  GetWebsite({
    required this.data,
    required this.message,
    required this.status,
  });
  factory GetWebsite.fromJson(Map<String, dynamic> json) => GetWebsite(
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );
  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}
class Data {
  int? id;
  String? url;
  String? videoLink;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Data({
     this.id,
     this.url,
     this.videoLink,
     this.status,
     this.createdAt,
     this.updatedAt,
  });
  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    url: json["url"],
    videoLink: json["Video_link"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "Video_link": videoLink,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}