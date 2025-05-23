import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    indicatorColor: AppColors.whiteColor,
    focusColor: AppColors.whiteBgColor,
      primaryColor: AppColors.primaryLight,
    cardColor: AppColors.primaryLight,
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
          color: AppColors.whiteColor,
          iconTheme: IconThemeData(
              color: AppColors.primaryLight
          )
      ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black,
          headlineSmall: AppStyles.medium16Primary,
          bodyLarge: AppStyles.bold16Black
      ),

      timePickerTheme: TimePickerThemeData(
        dialHandColor: AppColors.primaryLight,
        dialBackgroundColor: AppColors.whiteColor,
        entryModeIconColor: AppColors.primaryLight,
        hourMinuteColor: AppColors.whiteColor,
        hourMinuteTextColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)),
        confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)
        ),
        dayPeriodColor: AppColors.primaryLight,
        dayPeriodTextColor: AppColors.blackColor,
        timeSelectorSeparatorColor: WidgetStatePropertyAll(
            AppColors.primaryLight),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryLight)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryLight)),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.whiteColor,
        dividerColor: AppColors.primaryLight,
        todayBackgroundColor: WidgetStatePropertyAll(AppColors.primaryLight),
        cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)),
        confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)
        ),
      )
  );

  static final ThemeData darkTheme = ThemeData(
      indicatorColor: AppColors.blackColor,
      focusColor: AppColors.primaryLight,
      primaryColor: AppColors.primaryDark,
      cardColor: AppColors.whiteColor,
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
          color: AppColors.primaryDark,
          iconTheme: IconThemeData(
              color: AppColors.primaryLight
          )
      ),
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20white,
          headlineSmall: AppStyles.medium16white,
          bodyLarge: AppStyles.bold16White
      ),

      timePickerTheme: TimePickerThemeData(
        dialHandColor: AppColors.primaryLight,
        dialBackgroundColor: AppColors.whiteColor,
        entryModeIconColor: AppColors.primaryLight,
        hourMinuteColor: AppColors.whiteColor,
        hourMinuteTextColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)),
        confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)
        ),
        dayPeriodColor: AppColors.primaryLight,
        dayPeriodTextColor: AppColors.blackColor,
        timeSelectorSeparatorColor: WidgetStatePropertyAll(
            AppColors.primaryLight),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryLight)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryLight)),
        ),
      ),

      datePickerTheme: DatePickerThemeData(
        backgroundColor: AppColors.whiteColor,
        dividerColor: AppColors.primaryLight,
        todayBackgroundColor: WidgetStatePropertyAll(AppColors.primaryLight),
        cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)),
        confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.primaryLight)
        ),
      )
  );
}
