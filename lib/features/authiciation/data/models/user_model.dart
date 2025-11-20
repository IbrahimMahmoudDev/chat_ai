import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.password,
    required super.uId,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      password: '',
    );
  }

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      uId: json['uId'] ?? '',
      password: json['password'] ?? '',
    );
  }


  factory UserModel.formEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
      password:user.password ?? '',
    );
  }

  toMap() {
    return {'name': name, 'email': email, 'uId': uId,};
  }
}
