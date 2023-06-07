

import 'dart:convert';

GetJobStatus getJobStatusFromJson(String str) => GetJobStatus.fromJson(json.decode(str));

String getJobStatusToJson(GetJobStatus data) => json.encode(data.toJson());

class GetJobStatus {
  List<Datum> data;
  String message;
  bool status;

  GetJobStatus({
   required this.data,
   required this.message,
   required this.status,
  });

  factory GetJobStatus.fromJson(Map<String, dynamic> json) => GetJobStatus(
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
  String? noCount;
  String? title;

  Datum({
    this.noCount,
    this.title,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    noCount: json["no_count"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "no_count": noCount,
    "title": title,
  };
}
