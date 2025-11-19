import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/execption.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/backend_point.dart';
import '../../../../core/services/data_base_services.dart';
import '../../../../core/services/firebase_auth_services.dart';
import '../../../../core/services/shared_prefrence_singleton.dart';
import '../../domain/entites/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  FirebaseAuthServices firebaseAuthServices;
  DataBaseServices dataBaseServices;
  AuthRepoImpl({
    required this.firebaseAuthServices,
    required this.dataBaseServices,
  });
  User? user;

  @override
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      var user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(
        user: UserEntity(name: name, email: email, uId: user.uid),
      );
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(errorMessage: e.toString()));
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()} ',
      );
      return left(
        ServerFailure(errorMessage: 'there was an error, please tyr again'),
      );
    }
  }

  Future<void> deleteUser(user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()} ',
      );
      return left(
        ServerFailure(errorMessage: 'there was an error, please tyr again'),
      );
    }
  }



  @override
  Future addUserData({required UserEntity user}) async {
    await dataBaseServices.addData(
      path: BackEndEndPoint.kAddUserData,
      data: UserModel.formEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var userData = await dataBaseServices.getData(
      path: BackEndEndPoint.kGetUserData,
      documentId: uid,
    );
    return UserModel.fromJson(json: userData);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.formEntity(user).toMap());

    await Prefs.setString(BackEndEndPoint.kUserData, jsonData);
  }
}
