import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/authentication/login/login_screen.dart';
import 'package:event_planning_app/utils/app_assets.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../providers/language_provider.dart';
import '../../../../utils/app_colors.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = 'profile_tab';

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? selectedLanguage;
  ThemeMode? selectedTheme;

  @override
  void initState() {
    super.initState();
    final languageProvider = Provider.of<LanguageProvider>(
        context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    selectedLanguage = languageProvider.currentLocale.languageCode;
    selectedTheme = themeProvider.currentTheme;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * 0.20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start
          ,
          children: [
            Image.asset(AppAssets.profilePicture),
            SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Route Academy',
                  style: AppStyles.bold24white,),
                Text('route@gmail.com',
                  style: AppStyles.medium16white,)
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              child: DropdownMenu(
                width: width,
                textStyle: AppStyles.bold20Primary,
                trailingIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.primaryLight,
                  size: 34,
                ),
                selectedTrailingIcon: Icon(
                  Icons.arrow_drop_up_rounded,
                  color: AppColors.primaryLight,
                  size: 34,
                ),
                initialSelection: selectedLanguage,

                ///languageProvider.currentLocal,
                onSelected: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedLanguage = value; // Update the state
                    });
                    languageProvider.changeLanguage(value);
                  }
                },
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primaryLight,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primaryLight,
                      width: 2,
                    ),
                  ),
                ),
                dropdownMenuEntries: <DropdownMenuEntry<String>>[
                  DropdownMenuEntry<String>(
                    value: 'en',
                    label: AppLocalizations.of(context)!.english,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.primaryLight,
                      ),
                    ),
                  ),
                  DropdownMenuEntry<String>(
                    value: 'ar',
                    label: AppLocalizations.of(context)!.arabic,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
                /*onSelected: (value) {
                  if (value == 'en') {
                    languageProvider.changeLanguage('en');
                  } else if (value == 'ar') {
                    languageProvider.changeLanguage('ar');
                  }
                },*/
              ),
            ),

            SizedBox(height: height * 0.02),

            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.02),
              child: DropdownMenu(
                width: width,
                textStyle: AppStyles.bold20Primary,
                trailingIcon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.primaryLight,
                  size: 34,
                ),
                selectedTrailingIcon: Icon(
                  Icons.arrow_drop_up_rounded,
                  color: AppColors.primaryLight,
                  size: 34,
                ),
                initialSelection: selectedTheme,

                ///themeProvider.currentTheme,
                onSelected: (ThemeMode? value) {
                  if (value != null) {
                    setState(() {
                      selectedTheme = value; // Update the state
                    });
                    themeProvider.changeTheme(value);
                  }
                },
                inputDecorationTheme: InputDecorationTheme(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primaryLight,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primaryLight,
                      width: 2,
                    ),
                  ),
                ),
                dropdownMenuEntries: <DropdownMenuEntry<ThemeMode>>[
                  DropdownMenuEntry<ThemeMode>(
                    value: ThemeMode.light,
                    label: AppLocalizations.of(context)!.light,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.primaryLight,
                      ),
                    ),
                  ),
                  DropdownMenuEntry<ThemeMode>(
                    value: ThemeMode.dark,
                    label: AppLocalizations.of(context)!.dark,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
                /*onSelected: (value) {
                  if (value == ThemeMode.light) {
                    themeProvider.changeTheme(ThemeMode.light);
                  } else if (value == ThemeMode.dark) {
                    themeProvider.changeTheme(ThemeMode.dark);
                  }
                },*/
              ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: height * 0.02)
                ),
                onPressed: () {
                  ///FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed(
                      LoginScreen.routeName);
                },
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppColors.whiteColor, size: 25,),
                    Text(AppLocalizations.of(context)!.logout,
                      style: AppStyles.regular14white,)
                  ],
                )
            ),
            SizedBox(height: height * 0.03,)
          ],
        ),
      ),
    );
  }
}
