import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../utils/app_styles.dart';

class OnboardingWidget extends StatelessWidget {
  String imagePath;
  String title;
  String description;

  OnboardingWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: height * 0.01),
        Image.asset(imagePath, height: height * 0.42, width: width * 0.91),
        SizedBox(height: height * 0.02),
        Text(title, textAlign: TextAlign.start, style: AppStyles.bold20Primary),
        SizedBox(height: height * 0.02),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.start,
            style:
                themeProvider.currentTheme == ThemeMode.dark
                    ? AppStyles.medium16white
                    : AppStyles.medium16black,
          ),
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
