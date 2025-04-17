import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_styles.dart';
import 'authentication/login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'introduction_screen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  bool isEnglish = true;
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Image.asset(AppAssets.logoTop), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            themeProvider.currentTheme == ThemeMode.light
                ? Image.asset(AppAssets.beingCreativeImg)
                : Image.asset(AppAssets.designerDeskImg),
            SizedBox(height: height * 0.02),

            Text(
              AppLocalizations.of(context)!.personalize_your_experience,
              style: AppStyles.bold20Primary,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: height * 0.02),

            Text(
              AppLocalizations.of(context)!.choose,
              style:
                  themeProvider.currentTheme == ThemeMode.dark
                      ? AppStyles.medium16white
                      : AppStyles.medium16black,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: height * 0.03),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: AppStyles.medium20Primary,
                      textAlign: TextAlign.left,
                    ),
                    AnimatedToggleSwitch<bool>.rolling(
                      current: isEnglish,
                      spacing: 5,
                      height: height * 0.04,
                      indicatorSize: Size(30, 30),
                      style: ToggleStyle(
                        borderColor: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(30),
                        backgroundColor:
                            isLightMode
                                ? AppColors.whiteColor
                                : AppColors.primaryDark,
                        indicatorColor: AppColors.primaryLight,
                      ),
                      values: [true, false],
                      iconBuilder: (value, foreground) {
                        return value
                            ? Image.asset(
                              AppAssets.englishImg,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            )
                            : Image.asset(
                              AppAssets.egyptImg,
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            );
                      },
                      onChanged: (value) {
                        setState(() {
                          isEnglish = value;
                        });
                        languageProvider.changeLanguage(value ? 'en' : 'ar');
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: AppStyles.medium20Primary,
                      textAlign: TextAlign.left,
                    ),
                    AnimatedToggleSwitch<bool>.rolling(
                      current: isLightMode,
                      spacing: 5,
                      height: height * 0.04,
                      indicatorSize: Size(30, 30),
                      style: ToggleStyle(
                        borderColor: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(30),
                        backgroundColor:
                            isLightMode
                                ? AppColors.whiteColor
                                : AppColors.primaryDark,
                        indicatorColor: AppColors.primaryLight,
                      ),
                      values: [true, false],
                      iconBuilder: (value, foreground) {
                        if (value == isLightMode) {
                          return Icon(
                            isLightMode
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode,
                            color:
                                isLightMode
                                    ? AppColors.whiteColor
                                    : AppColors.primaryDark,
                          );
                        } else {
                          return Icon(
                            isLightMode
                                ? Icons.dark_mode
                                : Icons.light_mode_outlined,
                            color: AppColors.primaryLight,
                          );
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          isLightMode = value;
                        });
                        themeProvider.changeTheme(
                          value ? ThemeMode.light : ThemeMode.dark,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: height * 0.03),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02,
                  vertical: height * 0.01,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.lets_start,
                style: AppStyles.medium20white,
              ),

              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
