import 'package:chat_ai/features/authiciation/presentation/views/widgets/show_snack_bar.dart';
import 'package:chat_ai/features/authiciation/presentation/views/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/shared_prefrence_singleton.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../../../home/presentation/views/main_view.dart';
import '../../../../on_boarding_screen/presentation/views/on_board_view.dart';
import '../../manager/cubits/signup_cubit/signup_cubit.dart';
import '../login_view.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          final onboardingSeen = Prefs.getBool(kOnBoardingSeen) ?? false;
          if (!onboardingSeen) {
            Navigator.pushReplacementNamed(context, OnBoardView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, MainView.routeName);
          }

          showSnackBar(context, 'Signed up successfully', Colors.green);
        }
        if (state is SignupFailure) {
          showSnackBar(context, state.errorMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupLoading ? true : false,
          child: SignupViewBody(),
        );
      },
    );
  }
}
