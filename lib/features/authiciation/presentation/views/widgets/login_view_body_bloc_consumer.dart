import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:chat_ai/features/on_boarding_screen/presentation/views/on_board_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../../../home/presentation/views/main_view.dart';
import '../../manager/cubits/signin_cubit/sign_in_cubit.dart';
import '../../manager/cubits/signin_cubit/sign_in_state.dart';
import 'login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.pushNamed(context, OnBoardView.routeName);
          showSnackBar(context, 'Signed in successfully',Colors.green);
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