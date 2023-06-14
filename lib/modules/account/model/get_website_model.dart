// To parse this JSON data, do
//
//     final getwebsite = getwebsiteFromJson(jsonString);
import 'dart:convert';
Getwebsite getwebsiteFromJson(String str) => Getwebsite.fromJson(json.decode(str));
String getwebsiteToJson(Getwebsite data) => json.encode(data.toJson());
class Getwebsite {
List<Datum> data;
String message;
bool status;
Getwebsite({
required this.data,
required this.message,
required this.status,
});
factory Getwebsite.fromJson(Map<String, dynamic> json) => Getwebsite(
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
int id;
String url;
String videoLink;
String status;
DateTime createdAt;
DateTime updatedAt;
Datum({
required this.id,
required this.url,
required this.videoLink,
required this.status,
required this.createdAt,
required this.updatedAt,
});
factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
"created_at": createdAt.toIso8601String(),
"updated_at": updatedAt.toIso8601String(),
};
}