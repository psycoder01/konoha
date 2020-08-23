import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

getToken(key) async{
  return await storage.read(key:key); 
}

storeToken(key,value) async{
  return await storage.write(key:key,value:value);
}

delToken(key) async{
  return await storage.delete(key:key);
}
