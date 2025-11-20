import 'dart:convert';

import '../../features/authiciation/data/models/user_model.dart';
import '../../features/authiciation/domain/entites/user_entity.dart';
import '../services/backend_point.dart';
import '../services/shared_prefrence_singleton.dart';


UserEntity getUser() {
  var jsonString = Prefs.getString(BackEndEndPoint.kUserData);
  if (jsonString == null) {
    throw Exception("لا يوجد بيانات مستخدم محفوظة");
  }
  var userEntity = UserModel.fromJson(json: jsonDecode(jsonString));
  print("اسم المستخدم: ${userEntity.name}");
  return userEntity;
}
