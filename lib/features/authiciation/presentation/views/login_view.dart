import 'package:chat_ai/core/widgets/custom_progress_hud.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/login_view_body.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/git_it_services.dart';
import '../../../home/presentation/views/main_view.dart';
import '../../domain/repo/auth_repo.dart';
import '../manager/cubits/signin_cubit/sign_in_cubit.dart';
import '../manager/cubits/signin_cubit/sign_in_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoginViewBodyBlocConsumer(),
      ),
    );
  }
}

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.pushNamed(context, MainView.routeName);
          showSnackBar(context, 'Signed in successfully', Colors.green);
        }
        if (state is SignInFailure) {
          showSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignInLoading,
          child: LoginViewBody(),
        );
      },
    );
  }
}
