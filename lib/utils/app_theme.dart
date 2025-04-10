import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black
      )
  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white
      )
  );
}
