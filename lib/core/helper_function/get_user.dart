import '../../features/authiciation/data/models/user_model.dart';
import '../../features/authiciation/domain/entites/user_entity.dart';
import '../services/shared_prefrence_singleton.dart';


// UserEntity getUser() {
//   var jsonString = Prefs.getString(BackEndEndPoint.kUserData);
//   if (jsonString == null) {
//     throw Exception("No user data found");
//   }
//   var userEntity = UserModel.fromJson(json: jsonDecode(jsonString));
//   print("User name: ${userEntity.name}");
//   return userEntity;
// }

UserEntity getUser() {
  String name = Prefs.getString('userName') ?? '';
  String email = Prefs.getString('userEmail') ?? '';
  String uid = Prefs.getString('userUid') ?? '';

  if (name.isEmpty || email.isEmpty || uid.isEmpty) {
    throw Exception("No user data found");
  }

  return UserModel(
    name: name,
    email: email,
    password: '',
    uId: uid,
  );
}