import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';


import '../errors/execption.dart';

class FirebaseAuthServices {
  Future deleteUser(){
    return FirebaseAuth.instance.currentUser!.delete();
  }
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthServices.createUserWithEmailAndPassword: ${e.toString()} and code ${e.code} ',
      );
      if (e.code == 'weak-password') {
        throw CustomException(message: 'كلمة المرور ضعيفة جدًا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'هذا البريد الإلكتروني مستخدم بالفعل.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالانترنت');
      } else {
        throw CustomException(message: 'حدث خطأ، من فضلك حاول مرة أخرى.');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices.createUserWithEmailAndPassword: ${e.toString()} ',
      );
      throw CustomException(message: 'حدث خطأ، من فضلك حاول مرة أخرى.');
    }
  }

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'Exception in FirebaseAuthServices.signInWithEmailAndPassword: ${e.toString()} and code ${e.code} ',
      );
      if (e.code == 'user-not-found') {
        throw CustomException(
          message: 'لا يوجد مستخدم مسجل بهذا البريد الإلكتروني.',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'صيغة البريد الإلكتروني غير صحيحة.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالانترنت');
      } else {
        throw CustomException(message: 'حدث خطأ، من فضلك حاول مرة أخرى.');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices.signInWithEmailAndPassword: ${e.toString()} ',
      );
      throw CustomException(message: 'حدث خطأ، من فضلك حاول مرة أخرى.');
    }
  }



  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  // String generateNonce([int length = 32]) {
  //   final charset =
  //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  //   final random = math.Random.secure();
  //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
  //       .join();
  // }
  //
  // /// Returns the sha256 hash of [input] in hex notation.
  // String sha256ofString(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }



  bool isLoggedIn(){
    return FirebaseAuth.instance.currentUser != null;
  }
}
