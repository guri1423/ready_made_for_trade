
import 'dart:convert';

class AddAppointmentModel{

  AddAppointmentModel({
    required this.userId,
    required this.customerId,
    required this.projectTitle,
    required this.projectDescription,
    required this.status,
    required this.fullDate,
    required this.fullTime




  });

  String? userId;
  String? customerId;
  String? projectTitle;
  String? projectDescription;
  String? status;
  dynamic fullDate;
  dynamic fullTime;




  Map<String, dynamic> toJson() => {

    "user_id": userId,
    "customer_id": customerId,
    "full_time": fullTime,
    "full_date": fullDate,
    "project_title": projectTitle,
    "project_description": projectDescription,
    "status": status,




  };




}




AddAppointmentResponse addAppointmentResponseFromJson(String str) => AddAppointmentResponse.fromJson(json.decode(str));

String addAppointmentResponseToJson(AddAppointmentResponse data) => json.encode(data.toJson());

class AddAppointmentResponse {
  String? message;
  bool? status;
  int? jobId;
  int? appointmentId;

  AddAppointmentResponse({
    this.message,
    this.status,
    this.jobId,
    this.appointmentId,
  });

  factory AddAppointmentResponse.fromJson(Map<String, dynamic> json) => AddAppointmentResponse(
    message: json["message"],
    status: json["status"],
    jobId: json["Job_id"],
    appointmentId: json["appointment_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "Job_id": jobId,
    "appointment_id": appointmentId,
  };
}
