import 'package:event_planning_app/providers/language_provider.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/Intro_screen.dart';
import 'package:event_planning_app/ui/authentication/login/login_screen.dart';
import 'package:event_planning_app/ui/authentication/register/register_screen.dart';
import 'package:event_planning_app/ui/authentication/reset_password.dart';
import 'package:event_planning_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Evently App',
      debugShowCheckedModeBanner: false,
      initialRoute: IntroScreen.routeName,

      ///SplashScreen.routeName,
      routes: {
        //SplashScreen.routeName: (context) => SplashScreen(),
        IntroScreen.routeName: (context) => IntroScreen(),

        ///OnboardingScreen.routeName: (context) => OnboardingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ResetPassword.routeName: (context) => ResetPassword(),
        //HomeScreen.routeName: (context) => HomeScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentLocal),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.currentTheme,
    );
  }
}
