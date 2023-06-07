

import 'dart:io';

import 'package:email_validator/email_validator.dart';

dynamic validationTxtField(value){
  if(value.isEmpty){
    return "Field is mandatory";
  }else{
    return null;
  }
}

String? postalCodeValidator(String? value){
  if (value!.replaceAll(RegExp(r'[^0-9]'), '').length <= 10) {
    return 'Postal Code must be 10 digits long';
  }

  return null;

}

String? mobilNumberValidator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your phone number';
  }
  if (value.replaceAll(RegExp(r'[^0-9]'), '').length != 11) {
    return 'Phone number must be 11 digits long';
  }
  return null;
}



dynamic validationDropField(value){
  if(value == null){
    return "Field is mandatory";
  }else{
    return null;
  }
}




String? validateEmail(String email) {
   if(EmailValidator.validate(email) == false) {
     return "Enter proper email";
   }
   else{
     return null;
   }
}


double bottomBarHeight(){
  if (Platform.isIOS) {
    return 80;
  } else if (Platform.isAndroid) {
    return 50;

  } else {
    return 60;
  }
}
