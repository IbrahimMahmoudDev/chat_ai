import 'package:chat_ai/core/services/git_it_services.dart';
import 'package:chat_ai/features/splash_view/presentation/views/splash_view.dart';
import 'package:chat_ai/simple_block_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/helper_function/on_generate_route.dart';
import 'core/services/shared_prefrence_singleton.dart';
import 'core/utils/app_theme.dart';
import 'features/home/presentation/manager/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  await Prefs.init();
  setupServices();
  final themeCubit = ThemeCubit();
  runApp(BlocProvider<ThemeCubit>.value(
    value: themeCubit,
    // create: (context) => ThemeCubit(),
    child: ChatBotApp(),
  ));
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          onGenerateRoute: onGenerateRoute,
          initialRoute: SplashView.routeName,
          debugShowCheckedModeBanner: false,
          title: 'ChatBotApp',
        );
      },
    );
  }
}
