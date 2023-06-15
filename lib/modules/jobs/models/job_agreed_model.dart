
import 'dart:convert';

class JobAgreedModel{

  JobAgreedModel({
    required this.jobId,
    required this.jobStartDate,
    required this.jobEndDate,
    required this.jobStartTime,
    required this.jobEndTime,
    required this.depositAmount,
    required this.status,


  });

  int? jobId;
  String? jobStartDate;
  String? jobEndDate;
  String? depositAmount;
  String? jobStartTime;
  String? jobEndTime;
  String? status;







  Map<String, dynamic> toJson() => {

    "job_start_date": jobStartDate,
    "job_end_date": jobEndDate,
    "deposit_amount": depositAmount,
    "job_id": jobId,
    "job_start_time": jobStartTime ,
    "job_end_time": jobEndTime ,
    "status": status







  };




}




JobAgreeResponse jobAgreeResponseFromJson(String str) => JobAgreeResponse.fromJson(json.decode(str));

String jobAgreeResponseToJson(JobAgreeResponse data) => json.encode(data.toJson());

class JobAgreeResponse {
  String message;
  int jobid;
  bool status;

  JobAgreeResponse({
   required this.message,
   required this.jobid,
   required this.status,
  });

  factory JobAgreeResponse.fromJson(Map<String, dynamic> json) => JobAgreeResponse(
    message: json["message"],
    jobid: json["jobid"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "jobid": jobid,
    "status": status,
  };
}
