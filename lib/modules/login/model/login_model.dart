

class LoginRequestModal{


  //constructor
  LoginRequestModal({
    required this.email,
    required this.password,


  });

  String? email;
  String? password;


  // factory Register.fromJson(Map<String, dynamic>json) => Register();

  Map<String, dynamic> toJson() => {

    "email": email,
    "password": password,


  };




}


class ChangePasswordModal{


  //constructor
  ChangePasswordModal({
    required this.email,
    required this.password,


  });

  String? email;
  String? password;


  // factory Register.fromJson(Map<String, dynamic>json) => Register();

  Map<String, dynamic> toJson() => {

    "email": email,
    "newpassword": password,


  };




}