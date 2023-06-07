

class AddProjectModel{


  AddProjectModel({
    required this.projectName,
    required this.userId,
    required this.imagesList,



  });

  String? projectName;
  String? userId;
  List<String>? imagesList;


  // factory Register.fromJson(Map<String, dynamic>json) => Register();

  Map<String, dynamic> toJson() => {

    "projecttitle": projectName,
    "project_images[]": imagesList,
    "user_id": userId


  };




}