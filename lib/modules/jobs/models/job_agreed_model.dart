
import 'dart:convert';

class JobAgreedModel{

  JobAgreedModel({
    required this.jobId,
    required this.jobStartDate,
    required this.jobStartMonth,
    required this.jobStartYear,
    required this.jobEndDate,
    required this.jobEndMonth,
    required this.jobEndYear,
    required this.depositAmount,
    required this.jobStartHours,
    required this.jobStartMinutes,
    required this.jobEndHours,
    required this.jobEndMinutes,


  });

  int? jobId;
  String? jobStartDate;
  String? jobStartMonth;
  String? jobStartYear;
  String? jobEndDate;
  String? jobEndMonth;
  String? jobEndYear;
  String? depositAmount;
  String? jobStartHours;
  String? jobStartMinutes;
  String? jobEndMinutes;
  String? jobEndHours;







  Map<String, dynamic> toJson() => {

    "job_start_date": jobStartDate,
    "job_end_date": jobEndDate,
    "deposit_amount": depositAmount,
    "job_id": jobId,
    "job_start_month": jobStartMonth,
    "job_start_year": jobStartYear,
    "job_end_month": jobEndMonth,
    "job_end_year": jobEndYear,
    "job_start_hourse": jobStartHours ,
    "job_start_minutes": jobStartMinutes,
    "job_end_hourse": jobEndHours,
    "job_end_minutes" : jobEndMinutes,







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
