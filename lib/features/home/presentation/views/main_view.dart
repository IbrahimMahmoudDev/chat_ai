import 'package:chat_ai/core/services/git_it_services.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/custom_drawer_widget.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/chat_services.dart';
import '../../domain/chat_repo.dart';
import '../manager/chat_cubit/chat_cubit.dart';
import '../manager/conversations_cubit/conversations_cubit.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  static const String routeName = 'main_view';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConversationsCubit(getIt<ChatService>()),
        ),
        BlocProvider(
          create: (context) => ChatCubit(
            chatService: getIt<ChatService>(),
            repo: getIt<ChatRepo>(),
          ),
        ),
      ],
      child: Scaffold(
        drawer: CustomDrawerWidget(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppBarTheme.of(context).backgroundColor,
          title: const CustomHomeAppBar(),
        ),
        body: MainViewBody(),
      ),
    );
  }
}
