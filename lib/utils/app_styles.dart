import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle bold20Black = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
      color: AppColors.blackColor
  );
  static TextStyle bold20white = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColors.whiteTextColor
  );
  static TextStyle bold20Primary = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColors.primaryLight
  );
  static TextStyle medium16black = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.blackColor
  );
  static TextStyle medium20Primary = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: AppColors.primaryLight
  );
  static TextStyle medium16white = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.whiteTextColor
  );
  static TextStyle medium20white = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: AppColors.whiteColor
  );
}
