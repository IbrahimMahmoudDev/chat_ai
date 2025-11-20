
import 'package:chat_ai/features/home/presentation/views/widgets/custom_drawer_widget.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:chat_ai/features/home/presentation/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  static const String routeName = 'main_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerWidget(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomHomeAppBar(),
      ),
      body: MainViewBody(),
    );
  }
}


