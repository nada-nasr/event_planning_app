import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/my_user.dart';
import 'package:event_planning_app/ui/authentication/login/login_screen.dart';
import 'package:event_planning_app/ui/home/home_screen.dart';
import 'package:event_planning_app/ui/home/widget/custom_elevated_button.dart';
import 'package:event_planning_app/ui/home/widget/custom_text_field.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:event_planning_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/language_provider.dart';
import '../../../providers/event_list_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  bool isEnglish = true;
  bool isLightMode = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.register,
          style:
              themeProvider.currentTheme == ThemeMode.light
                  ? AppStyles.medium20Black
                  : AppStyles.medium20Primary,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: height * 0.02),
                Image.asset(
                  AppAssets.logo,
                  height: height * 0.22,
                  width: width * 0.34,
                ),
                SizedBox(height: height * 0.02),

                /// Name
                CustomTextField(
                  prefixIcon: themeProvider.currentTheme == ThemeMode.light
                      ? Image.asset(AppAssets.iconName)
                      : Image.asset(AppAssets.iconNameDark),
                  hintText: AppLocalizations.of(context)!.name,
                  hintStyle:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppStyles.medium16Gray
                      : AppStyles.medium16white,
                  borderColor:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryLight,

                  controller: nameController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),

                /// Email
                CustomTextField(
                  keyboardInputType: TextInputType.emailAddress,
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
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please enter email';
                    }
                    final bool emailValid =
                    RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if (!emailValid) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),

                /// Password
                CustomTextField(
                  keyboardInputType: TextInputType.number,
                  obscureText: true,
                  prefixIcon: themeProvider.currentTheme == ThemeMode.light
                      ? Image.asset(AppAssets.iconPassword)
                      : Image.asset(AppAssets.iconPasswordDark),
                  hintText: AppLocalizations.of(context)!.password,
                  suffixIcon: themeProvider.currentTheme == ThemeMode.light
                      ? Image.asset(AppAssets.iconShowPassword)
                      : Image.asset(AppAssets.iconShowPasswordDark),
                  hintStyle:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppStyles.medium16Gray
                      : AppStyles.medium16white,
                  borderColor:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryLight,

                  controller: passwordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please enter password';
                    }
                    if (text.length < 8) {
                      return 'Password should be at least 8 characters.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),

                /// Re Password
                CustomTextField(
                  keyboardInputType: TextInputType.number,
                  obscureText: true,
                  prefixIcon: themeProvider.currentTheme == ThemeMode.light
                      ? Image.asset(AppAssets.iconPassword)
                      : Image.asset(AppAssets.iconPasswordDark),
                  hintText: AppLocalizations.of(context)!.re_password,
                  suffixIcon: themeProvider.currentTheme == ThemeMode.light
                      ? Image.asset(AppAssets.iconShowPassword)
                      : Image.asset(AppAssets.iconShowPasswordDark),
                  hintStyle:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppStyles.medium16Gray
                      : AppStyles.medium16white,
                  borderColor:
                  themeProvider.currentTheme == ThemeMode.light
                      ? AppColors.greyColor
                      : AppColors.primaryLight,

                  controller: rePasswordController,
                  validator: (text) {
                    if (text == null || text
                        .trim()
                        .isEmpty) {
                      return 'Please enter password';
                    }
                    if (text.length < 8) {
                      return 'Password should be at least 8 characters.';
                    }
                    if (rePasswordController.text != passwordController.text) {
                      return "Re-Password doesn't match password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),

                CustomElevatedButton(
                    onButtonClick: register,
                    text: AppLocalizations.of(context)!.create_account),
                SizedBox(height: height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_account,
                      style:
                      themeProvider.currentTheme == ThemeMode.light
                          ? AppStyles.medium16black
                          : AppStyles.medium16white,
                    ),
                    TextButton(
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: AppStyles.medium20Primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),
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
      ),
    );
  }

  void register() async {
    if (formKey.currentState!.validate() == true) {
      //todo: show loading
      DialogUtils.showLoading(
          context: context,
          message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //todo: save user to fireStore
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text
        );
        await FirebaseUtils.addUserToFireStore(myUser);
        //todo: save user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        var eventListProvider = Provider.of<EventListProvider>(
            context, listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);

        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: 'Register successfully',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
        );

        print('register successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'The password provided is too weak.',
              title: 'Error',
              posActionName: 'Ok');
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              title: 'Error',
              posActionName: 'Ok');
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'Error',
            posActionName: 'Ok');
        print(e.toString());
        print(e);
      }
    }
  }
}
