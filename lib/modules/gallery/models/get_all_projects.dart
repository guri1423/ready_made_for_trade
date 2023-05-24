

import 'dart:convert';

GetAllProjects getAllProjectsFromJson(String str) => GetAllProjects.fromJson(json.decode(str));

String getAllProjectsToJson(GetAllProjects data) => json.encode(data.toJson());

class GetAllProjects {
  List<ProjectsData> data;
  String message;
  bool status;

  GetAllProjects({
  required  this.data,
  required  this.message,
  required  this.status,
  });

  factory GetAllProjects.fromJson(Map<String, dynamic> json) => GetAllProjects(
    data: List<ProjectsData>.from(json["data"].map((x) => ProjectsData.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class ProjectsData {
  int? id;
  int? userId;
  String? projectTitle;
  List<String>? projectImages;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProjectsData({
    this.id,
    this.userId,
    this.projectTitle,
    this.projectImages,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectsData.fromJson(Map<String, dynamic> json) => ProjectsData(
    id: json["id"],
    userId: json["user_id"],
    projectTitle: json["project_title"],
    projectImages: List<String>.from(json["project_images"].map((x) => x)),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "project_title": projectTitle,
    "project_images": List<dynamic>.from(projectImages!.map((x) => x)),
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
