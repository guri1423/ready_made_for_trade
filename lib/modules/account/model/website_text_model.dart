import 'dart:convert';

GetWebsiteTextModel getWebsiteTextModelFromJson(String str) =>
    GetWebsiteTextModel.fromJson(jsonDecode(str));

class GetWebsiteTextModel {
  final EditWebsiteData? data;
  final String message;
  final bool status;

  GetWebsiteTextModel({
    this.data,
    required this.message,
    required this.status,
  });

  factory GetWebsiteTextModel.fromJson(Map<String, dynamic> json) {
    return GetWebsiteTextModel(
      data:
          json['data'] != null ? EditWebsiteData.fromJson(json['data']) : null,
      message: json['message'],
      status: json['status'],
    );
  }
}

class EditWebsiteData {
  final int? id;
  final String userId;
  final String homeTitle;
  final String homeDescription;
  final String aboutTitle;
  final String aboutDescription;
  final String servicesTitle;
  final String servicesDescription;
  final String themeColours;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EditWebsiteData({
    this.id,
    required this.userId,
    required this.homeTitle,
    required this.homeDescription,
    required this.aboutTitle,
    required this.aboutDescription,
    required this.servicesTitle,
    required this.servicesDescription,
    required this.themeColours,
    this.createdAt,
    this.updatedAt,
  });

  factory EditWebsiteData.fromJson(Map<String, dynamic> json) {
    return EditWebsiteData(
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

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'home_title': homeTitle,
      'home_description': homeDescription,
      'about_title': aboutTitle,
      'about_description': aboutDescription,
      'services_title': servicesTitle,
      'services_description': servicesDescription,
      'theme_colours': themeColours,
    };
  }
}
