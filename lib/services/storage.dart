

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ready_made_4_trade/core/strings.dart';

class StorageServices{


  final storage =  const FlutterSecureStorage();

  setEmail(String email)async{
    await storage.write(key: Strings.emailKey, value: email);
  }
  setUserLoggedIn(String val)async{
    await storage.write(key: Strings.loggedKey, value: val);
  }

  Future<String?> getEmail()async{
    return await storage.read(key: Strings.emailKey);

  }

  setUserId(String id)async{
    await storage.write(key: Strings.userIdKey, value: id);
  }



  Future<String?>getUserId()async{
    return await storage.read(key: Strings.userIdKey);
  }

  Future<String?>getLoggedInStatus()async{
    return await storage.read(key: Strings.loggedKey);
  }


  clearStorage()async{
    await storage.deleteAll();
  }

}