import 'package:evently_app/SharedPreferences/app_shared_preferences.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:evently_app/providers/app_auth_signIn_provider.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/create_event_screen.dart';
import 'package:evently_app/ui/home_screen/home_screen.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:evently_app/ui/onboarding/onboarding_screen.dart';
import 'package:evently_app/ui/register/registr_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => AppAuthProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguageProvider appLanguageProvider = Provider.of<AppLanguageProvider>(
      context,
    );
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);
    AppAuthProvider appAuthProvider = Provider.of<AppAuthProvider>(context);

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeProvider.getSelectedThemMode(),
      locale: Locale(appLanguageProvider.getAppLanguage()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: (appAuthProvider.isLoggedInBefore())
          ? AppRoutes.OnboardingScreen.name
          : AppRoutes.LoginScreen.name,
      routes: {
        AppRoutes.OnboardingScreen.name: (context) => OnboardingScreen(),
        AppRoutes.RegistrScreen.name: (context) => RegistrScreen(),
        AppRoutes.LoginScreen.name: (context) => LoginScreen(),
        AppRoutes.HomeScreen.name: (context) => HomeScreen(),
        AppRoutes.CreateEventScreen.name: (context) => CreateEventScreen(),
      },
    );
  }
}
