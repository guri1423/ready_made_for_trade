

class AddReminderModel{

  AddReminderModel({
    required this.userId,
    required this.customerId,
    required this.fullDate,
    required this.fullTime,
    required this.projectTitle,
    required this.projectDescription,
    required this.jobId,
    required this.projectId,




  });

  String? userId;
  String? customerId;
  dynamic fullDate;
  dynamic fullTime;
  String? projectTitle;
  String? projectDescription;
  String? jobId;
  String? projectId;




  Map<String, dynamic> toJson() => {

    "user_id": userId,
    "customer_id": customerId,
    "full_time": fullTime,
    "full_date": fullDate,
    "project_title": projectTitle,
    "project_description": projectDescription,
    "job_id": jobId,
    "project_id": projectId,




  };




}