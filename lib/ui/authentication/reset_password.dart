import 'package:event_planning_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../home/widget/custom_text_field.dart';

class ResetPassword extends StatelessWidget {
  static const String routeName = 'resetPassword_screen';
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forget_password,
          style:
              themeProvider.currentTheme == ThemeMode.light
                  ? AppStyles.medium20Black
                  : AppStyles.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.02,
        ),
        child: Column(
          children: [
            Image.asset(AppAssets.resetPass),
            SizedBox(height: height * 0.04),
            CustomTextField(
              prefixIcon: Image.asset(AppAssets.iconEmail),
              hintText: AppLocalizations.of(context)!.email,
              hintStyle:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppStyles.medium16Gray
                      : AppStyles.medium16white,
              borderColor:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryLight,

              ///controller: emailController,
              ///validator: (text){},
            ),

            /// Elevated Button ResetPassword
          ],
        ),
      ),
    );
  }
}
