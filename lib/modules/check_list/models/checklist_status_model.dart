import 'dart:convert';

UserChecklistStatus userChecklistStatusFromJson(String str) =>
    UserChecklistStatus.fromJson(json.decode(str));

class UserChecklistStatus {
  Data data;
  String message;
  bool status;

  UserChecklistStatus({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserChecklistStatus.fromJson(Map<String, dynamic> json) =>
      UserChecklistStatus(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );
}

class Data {
  String checkliststatus;

  Data({
    required this.checkliststatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    checkliststatus: json["checkliststatus"],
  );
}