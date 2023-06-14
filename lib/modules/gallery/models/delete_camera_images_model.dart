import 'dart:convert';
DeleteImages deleteImagesFromJson(String str) => DeleteImages.fromJson(json.decode(str));
String deleteImagesToJson(DeleteImages data) => json.encode(data.toJson());
class DeleteImages {
  String message;
  bool status;
  DeleteImages({
    required this.message,
    required this.status,
  });
  factory DeleteImages.fromJson(Map<String, dynamic> json) => DeleteImages(
    message: json["message"],
    status: json["status"],
  );
  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}