import 'package:event_planning_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
      ),
      body: ProfileTab(),
    );
  }
}
