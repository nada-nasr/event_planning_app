import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:event_planning_app/firebase_utils.dart';
import 'package:event_planning_app/model/my_user.dart';
import 'package:event_planning_app/providers/event_list_provider.dart';
import 'package:event_planning_app/providers/user_provider.dart';
import 'package:event_planning_app/ui/authentication/register/register_screen.dart';
import 'package:event_planning_app/ui/authentication/reset_password.dart';
import 'package:event_planning_app/ui/home/home_screen.dart';
import 'package:event_planning_app/ui/home/widget/custom_elevated_button.dart';
import 'package:event_planning_app/ui/home/widget/custom_text_field.dart';
import 'package:event_planning_app/utils/app_colors.dart';
import 'package:event_planning_app/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/dialog_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController(
      text: 'nada@gmail.com');
  TextEditingController passwordController = TextEditingController(
      text: '12345678');
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.03,
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
                  height: height * 0.24,
                  width: width * 0.34,
                ),
                SizedBox(height: height * 0.02),
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
                CustomTextField(
                  keyboardInputType: TextInputType.number,
                  obscureText: true,
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
                        Navigator.of(context).pushNamed(
                            ResetPassword.routeName);
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
                        Navigator.of(context).pushNamed(
                            RegisterScreen.routeName);
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
                        side: BorderSide(
                            width: 1, color: AppColors.primaryLight),
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

                    onPressed: () async {
                      //todo: login with google account
                      ///signInWithGoogle();
                      ///setState(() {});
                    }),
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
      ),
    );
  }

  void login() async {
    if (formKey.currentState!.validate() == true) {
      //todo: show loading
      DialogUtils.showLoading(
          context: context,
          message: 'Waiting...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        MyUser? user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        //todo: save user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);
        var eventListProvider = Provider.of<EventListProvider>(
            context, listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            title: 'Success',
            message: 'Login successfully',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
        );
        print('login successfully');
        print(credential.user?.uid ?? '');
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //todo: hide loading
          //todo: show message
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          //todo: hide loading
          //todo: show message
          print('Wrong password provided for that user.');
        }
        else if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMessage(
              context: context,
              message: 'The supplied auth credential is incorrect, malformed or has expired.',
              title: 'Error',
              posActionName: 'Ok');
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        }
      }
      catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'Error',
            posActionName: 'Ok');
        print(e);
      }
    }
  }

/*Future<UserCredential?> signInWithGoogle() async {
    try {
      // Show loading indicator
      DialogUtils.showLoading(
          context: context, message: 'Signing in with Google...');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        DialogUtils.hideLoading(context);
      }
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      if (googleAuth?.accessToken != null &&
          googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Sign in to Firebase with the Google credential
        final UserCredential userCredential =
        await FirebaseAuth.instance
            .signInWithCredential(credential);

        final User? firebaseUser = userCredential.user;

        if (firebaseUser != null) {
          // Check if the user exists in your Firestore
          MyUser? user = await FirebaseUtils
              .readUserFromFireStore(firebaseUser.uid);

          if (user == null) {
            // New user, navigate to registration or create user
            print(
                'New Google user signed in: ${firebaseUser.displayName}');
            // For simplicity, let's navigate to the register screen
            DialogUtils.hideLoading(context);
            Navigator.of(context)
                .pushReplacementNamed(RegisterScreen.routeName);
          }

          // Update the user provider
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.updateUser(user!);

          // Update the event list provider (if needed)
          var eventListProvider = Provider.of<EventListProvider>(
              context,
              listen: false);
          eventListProvider.changeSelectedIndex(
              0, userProvider.currentUser!.id);

          // Hide loading indicator
          DialogUtils.hideLoading(context);

          // Navigate to the home screen
          Navigator.of(context)
              .pushReplacementNamed(HomeScreen.routeName);
        } else {
          // Firebase sign-in failed
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context: context,
            title: 'Error',
            message: 'Firebase sign-in with Google failed.',
            posActionName: 'Ok',
          );
        }
      } else {
        // Google authentication failed
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          title: 'Error',
          message: 'Google authentication failed.',
          posActionName: 'Ok',
        );
      }
    } catch (e) {
      // Handle any errors during Google sign-in
      print('Error signing in with Google: $e');
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(
        context: context,
        message: 'Failed to sign in with Google: $e',
        title: 'Error',
        posActionName: 'Ok',
      );
    }
  }*/
}
