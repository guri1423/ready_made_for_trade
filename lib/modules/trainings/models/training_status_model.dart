import 'dart:convert';

UserTrainingStatus userTrainingStatusFromJson(String str) =>
    UserTrainingStatus.fromJson(json.decode(str));

String userTrainingStatusToJson(UserTrainingStatus data) =>
    json.encode(data.toJson());

class UserTrainingStatus {
  Data data;
  String message;
  bool status;

  UserTrainingStatus({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserTrainingStatus.fromJson(Map<String, dynamic> json) =>
      UserTrainingStatus(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  String checkTrainingstatus;

  Data({
    required this.checkTrainingstatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        checkTrainingstatus: json["checkTrainingstatus"],
      );

  Map<String, dynamic> toJson() => {
        "checkTrainingstatus": checkTrainingstatus,
      };
}
