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
        throw CustomException(message: 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'This email is already in use.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection. Please check your network and try again.');
      } else {
        throw CustomException(message: 'Failed to create account. Please try again later.');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices.createUserWithEmailAndPassword: ${e.toString()} ',
      );
      throw CustomException(message: 'An unexpected error occurred. Please try again.');
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
          message: 'No user found with this email.',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'Wrong password.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'Invalid email format.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection. Please check your network and try again.');
      } else {
        throw CustomException(message: 'Login failed. Please try again later.');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthServices.signInWithEmailAndPassword: ${e.toString()} ',
      );
      throw CustomException(message: 'An unexpected error occurred. Please try again.');
    }
  }




  bool isLoggedIn(){
    return FirebaseAuth.instance.currentUser != null;
  }
}
