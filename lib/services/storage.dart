

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ready_made_4_trade/core/strings.dart';

class StorageServices{


  final storage =  const FlutterSecureStorage();

  setEmail(String email)async{
    await storage.write(key: Strings.emailKey, value: email);
  }

  setPassword(String password)async{
    await storage.write(key: Strings.passwordKey, value: password);
  }
  removeEmailAndPass()async{
    await storage.delete(key: Strings.emailKey);
    await storage.delete(key: Strings.passwordKey);
  }
  setUserLoggedIn(String val)async{
    await storage.write(key: Strings.loggedKey, value: val);
  }

  Future<String?> getEmail()async{
    return await storage.read(key: Strings.emailKey);

  }

  Future<String?> getPassword()async{
    return await storage.read(key: Strings.passwordKey);

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