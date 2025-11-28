
import 'package:chat_ai/features/authiciation/presentation/views/widgets/signup_view_body_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/git_it_services.dart';
import '../../domain/repo/auth_repo.dart';
import '../manager/cubits/signup_cubit/signup_cubit.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup_view';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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


