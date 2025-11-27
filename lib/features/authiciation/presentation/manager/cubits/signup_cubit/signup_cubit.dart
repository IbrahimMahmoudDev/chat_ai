import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/services/shared_prefrence_singleton.dart';
import '../../../../../../core/utils/constant.dart';
import '../../../../domain/entites/user_entity.dart';
import '../../../../domain/repo/auth_repo.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email,
      password,
      name,
    );
    result.fold(
      (failure) => emit(SignupFailure(errorMessage: failure.errorMessage)),
      (userEntity) {
        Prefs.setBool(kOnBoardingSeen, false);
        emit(SignupSuccess(userEntity: userEntity));
      }
    );
  }
}
