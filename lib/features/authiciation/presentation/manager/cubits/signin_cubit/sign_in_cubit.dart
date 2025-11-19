import 'package:chat_ai/features/authiciation/presentation/manager/cubits/signin_cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repo/auth_repo.dart';


class SignInCubit extends Cubit<SignInState> {
  final AuthRepo authRepo;
  SignInCubit(this.authRepo) : super(SignInInitial());
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(SignInLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SignInFailure(errorMessage: failure.errorMessage)),
      (userEntity) => emit(SignInSuccess(userEntity: userEntity)),
    );
  }


}
