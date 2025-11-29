import 'package:chat_ai/features/authiciation/presentation/views/widgets/login_view_body_bloc_consumer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/git_it_services.dart';

import '../../domain/repo/auth_repo.dart';
import '../manager/cubits/signin_cubit/sign_in_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => SignInCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        backgroundColor:isDark ? Color(0xFF090909) : Colors.white,
        body: LoginViewBodyBlocConsumer(),
      ),
    );
  }
}
