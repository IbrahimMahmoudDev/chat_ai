import 'package:chat_ai/core/widgets/custom_progress_hud.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/git_it_services.dart';
import '../../domain/repo/auth_repo.dart';
import '../manager/cubits/signup_cubit/signup_cubit.dart';
import 'login_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignupCubit(
            getIt.get<AuthRepo>(),
          ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SignupViewBodyBlocConsumer(),
      ),
    );
  }
}

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
       if (state is SignupSuccess) {
         Navigator.pushNamed(context, LoginView.routeName);
         showSnackBar(context, 'Signed up successfully',Colors.green);
       }
       if (state is SignupFailure) {
         showSnackBar(context, state.errorMessage,Colors.red);
       }
      },
      builder: (context, state) {
        return CustomProgressHud(
            isLoading: state is SignupLoading ? true : false,
            child: SignupViewBody());
      },
    );
  }
}
