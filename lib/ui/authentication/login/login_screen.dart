import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_planning_app/ui/authentication/register/register_screen.dart';
import 'package:event_planning_app/ui/authentication/reset_password.dart';
import 'package:event_planning_app/ui/home/home_screen.dart';
import 'package:event_planning_app/ui/home/widget/custom_elevated_button.dart';
import 'package:event_planning_app/ui/home/widget/custom_text_field.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/app_assets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEnglish = true;
  bool isLightMode = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.02),
              Image.asset(
                AppAssets.logo,
                height: height * 0.24,
                width: width * 0.34,
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                prefixIcon: themeProvider.currentTheme == ThemeMode.light
                    ? Image.asset(AppAssets.iconEmail)
                    : Image.asset(AppAssets.iconEmailDark),
                hintText: AppLocalizations.of(context)!.email,
                hintStyle:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppStyles.medium16Gray
                        : AppStyles.medium16white,
                borderColor:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppColors.greyColor
                        : AppColors.primaryLight,

                controller: emailController,
                validator: (text) {},
              ),
              SizedBox(height: height * 0.02),
              CustomTextField(
                prefixIcon: themeProvider.currentTheme == ThemeMode.light
                    ? Image.asset(AppAssets.iconPassword)
                    : Image.asset(AppAssets.iconPasswordDark),
                hintText: AppLocalizations.of(context)!.password,
                hintStyle:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppStyles.medium16Gray
                        : AppStyles.medium16white,
                suffixIcon: themeProvider.currentTheme == ThemeMode.light
                    ? Image.asset(AppAssets.iconShowPassword)
                    : Image.asset(AppAssets.iconShowPasswordDark),
                borderColor:
                    themeProvider.currentTheme == ThemeMode.light
                        ? AppColors.greyColor
                        : AppColors.primaryLight,

                controller: passwordController,
                validator: (text) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: AppStyles.bold16Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                    onPressed: () {
                      //todo: navigate to forget password screen
                      Navigator.of(context).pushNamed(ResetPassword.routeName);
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              CustomElevatedButton(
                  onButtonClick: login,
                  text: AppLocalizations.of(context)!.login),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.do_not_have_an_account,
                    style:
                        themeProvider.currentTheme == ThemeMode.light
                            ? AppStyles.medium16black
                            : AppStyles.medium16white,
                  ),
                  TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: AppStyles.medium20Primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.primaryLight,
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: AppStyles.medium16Primary,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: AppColors.primaryLight,
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      themeProvider.currentTheme == ThemeMode.light
                          ? AppColors.whiteColor
                          : AppColors.primaryDark,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(width: 1, color: AppColors.primaryLight),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.googleImg),
                    SizedBox(width: width * 0.02),
                    Text(
                      AppLocalizations.of(context)!.login_with_google,
                      style: AppStyles.medium20Primary,
                    ),
                  ],
                ),

                onPressed: () {
                  //todo: login with google account
                },
              ),
              SizedBox(height: height * 0.03),

              Column(
                children: [
                  AnimatedToggleSwitch<bool>.rolling(
                    current: isEnglish,
                    spacing: 5,
                    height: height * 0.04,
                    indicatorSize: Size(30, 30),
                    style: ToggleStyle(
                      borderColor: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(30),
                      backgroundColor:
                          themeProvider.currentTheme == ThemeMode.light
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
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
