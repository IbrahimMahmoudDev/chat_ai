
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/firebase_auth_services.dart';
import '../../../../core/services/shared_prefrence_singleton.dart';
import '../../domain/entites/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepoImpl({required this.firebaseAuthServices});

  @override
  Future<Either<Failures, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      var user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // تحديث الاسم في Firebase User
      await user.updateDisplayName(name);

      // حفظ البيانات محلياً
      await Prefs.setString('userName', name);
      await Prefs.setString('userEmail', email);
      await Prefs.setString('userUid', user.uid);

      var userEntity = UserModel.fromFirebaseUser(user);
      return right(userEntity);
    } catch (e) {
      await firebaseAuthServices.deleteUser();
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthServices.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String name = user.displayName ?? Prefs.getString('userName') ?? '';
      var userEntity = UserModel(
        name: name,
        email: user.email ?? '',
        password: '',
        uId: user.uid,
      );

      // تحديث البيانات المحلية
      await Prefs.setString('userName', name);
      await Prefs.setString('userEmail', user.email ?? '');
      await Prefs.setString('userUid', user.uid);

      return right(userEntity);
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
