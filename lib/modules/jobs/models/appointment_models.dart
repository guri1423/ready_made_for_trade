
import 'dart:convert';

class AddAppointmentModel{

  AddAppointmentModel({
    required this.userId,
    required this.customerId,
    required this.date,
    required this.month,
    required this.year,
    required this.hours,
    required this.minutes,
    required this.projectTitle,
    required this.projectDescription,
    required this.status




  });

  String? userId;
  String? customerId;
  String? date;
  String? month;
  String? year;
  String? hours;
  String? minutes;
  String? projectTitle;
  String? projectDescription;
  String? status;




  Map<String, dynamic> toJson() => {

    "user_id": userId,
    "customer_id": customerId,
    "date": date,
    "month": month,
    "year": year,
    "hours": hours,
    "minutes": minutes,
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
