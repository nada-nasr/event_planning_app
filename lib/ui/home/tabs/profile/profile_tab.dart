import 'package:event_planning_app/providers/theme_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
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
              initialSelection: languageProvider.currentLocal,
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
                ),
                DropdownMenuEntry<String>(
                  value: 'ar',
                  label: AppLocalizations.of(context)!.arabic,
                ),
              ],
              onSelected: (value) {
                if (value == 'en') {
                  languageProvider.changeLanguage('en');
                } else if (value == 'ar') {
                  languageProvider.changeLanguage('ar');
                }
              },
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
              initialSelection: themeProvider.currentTheme,
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
                ),
                DropdownMenuEntry<ThemeMode>(
                  value: ThemeMode.dark,
                  label: AppLocalizations.of(context)!.dark,
                ),
              ],
              onSelected: (value) {
                if (value == ThemeMode.light) {
                  themeProvider.changeTheme(ThemeMode.light);
                } else if (value == ThemeMode.dark) {
                  themeProvider.changeTheme(ThemeMode.dark);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
