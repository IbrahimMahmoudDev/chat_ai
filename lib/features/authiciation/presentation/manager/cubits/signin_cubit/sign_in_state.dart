
import '../../../../domain/entites/user_entity.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final UserEntity userEntity;
  SignInSuccess({required this.userEntity});
}

class SignInFailure extends SignInState {
  final String errorMessage;
 SignInFailure({required this.errorMessage});
}
