import 'dart:convert';

GetWebsiteTextModel getWebsiteTextModelFromJson(String str) =>
    GetWebsiteTextModel.fromJson(jsonDecode(str));

class GetWebsiteTextModel {
  final Data? data;
  final String message;
  final bool status;

  GetWebsiteTextModel({
    this.data,
    required this.message,
    required this.status,
  });

  factory GetWebsiteTextModel.fromJson(Map<String, dynamic> json) {
    return GetWebsiteTextModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class Data {
  final int id;
  final String userId;
  final String homeTitle;
  final String homeDescription;
  final String aboutTitle;
  final String aboutDescription;
  final String servicesTitle;
  final String servicesDescription;
  final String themeColours;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.userId,
    required this.homeTitle,
    required this.homeDescription,
    required this.aboutTitle,
    required this.aboutDescription,
    required this.servicesTitle,
    required this.servicesDescription,
    required this.themeColours,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      userId: json['user_id'],
      homeTitle: json['home_title'],
      homeDescription: json['home_description'],
      aboutTitle: json['about_title'],
      aboutDescription: json['about_description'],
      servicesTitle: json['services_title'],
      servicesDescription: json['services_description'],
      themeColours: json['theme_colours'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
