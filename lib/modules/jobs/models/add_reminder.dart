

class AddReminderModel{

  AddReminderModel({
    required this.userId,
    required this.customerId,
    required this.date,
    required this.month,
    required this.year,
    required this.hours,
    required this.minutes,
    required this.projectTitle,
    required this.projectDescription,
    required this.jobId,
    required this.projectId,




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
  String? jobId;
  String? projectId;




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
    "job_id": jobId,
    "project_id": projectId,




  };




}