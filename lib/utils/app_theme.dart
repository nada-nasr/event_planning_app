import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.whiteColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12white,
        unselectedLabelStyle: AppStyles.bold12white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
        /*RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75),
          side: BorderSide(
            color: AppColors.whiteColor,
            width: 4
          )
        )*/
      ),
      appBarTheme: AppBarTheme(
          color: AppColors.whiteColor
      ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black
      )
  );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyles.bold12white,
        unselectedLabelStyle: AppStyles.bold12white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
        /*RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(75),
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 4
              )
          )*/
      ),
      appBarTheme: AppBarTheme(
          color: AppColors.primaryDark
      ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white
      )
  );
}
