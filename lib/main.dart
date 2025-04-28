import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/providers/language_provider.dart';
import 'package:event_planning_app/providers/theme_provider.dart';
import 'package:event_planning_app/ui/Intro_screen.dart';
import 'package:event_planning_app/ui/authentication/login/login_screen.dart';
import 'package:event_planning_app/ui/authentication/register/register_screen.dart';
import 'package:event_planning_app/ui/authentication/reset_password.dart';
import 'package:event_planning_app/ui/home/home_screen.dart';
import 'package:event_planning_app/ui/home/tabs/home_tab/add_event.dart';
import 'package:event_planning_app/ui/onboarding_screen/onboarding_screen.dart';
import 'package:event_planning_app/ui/splash_screen.dart';
import 'package:event_planning_app/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
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
      initialRoute: HomeScreen.routeName,

      ///SplashScreen.routeName,
      routes: {
        ///SplashScreen.routeName: (context) => SplashScreen(),
        ///IntroScreen.routeName: (context) => IntroScreen(),
        ///OnboardingScreen.routeName: (context) => OnboardingScreen(),
        ///LoginScreen.routeName: (context) => LoginScreen(),
        ///RegisterScreen.routeName: (context) => RegisterScreen(),
        ///ResetPassword.routeName: (context) => ResetPassword(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddEvent.routeName: (context) => AddEvent()
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
