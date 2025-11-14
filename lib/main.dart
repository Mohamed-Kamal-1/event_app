import 'package:evently_app/SharedPreferences/app_shared_preferences.dart';
import 'package:evently_app/SharedPreferences/onboarding_shared_preferences.dart';
import 'package:evently_app/providers/app_auth_provider.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/event/create_event/create_event_screen.dart';
import 'package:evently_app/ui/event/event_details/event_details.dart';
import 'package:evently_app/ui/home_screen/home_screen.dart';
import 'package:evently_app/ui/home_screen/tabs/map_tab/map_tab.dart';
import 'package:evently_app/ui/login/login_screen.dart';
import 'package:evently_app/ui/onboarding/complete_onboarding_screen.dart';
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
  await OnboardingSharedPreferences.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
          ChangeNotifierProvider(create: (context) => AppThemeProvider()),
          ChangeNotifierProvider(create: (context) => AppAuthProvider()),
        ],
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

      // initialRoute:AppRoutes.OnboardingScreen.name,
      initialRoute: (appAuthProvider.isLoggedInBefore())
          ? AppRoutes.HomeScreen.name
          : (OnboardingSharedPreferences.isSaved())
          ? AppRoutes.LoginScreen.name
          : AppRoutes.OnboardingScreen.name,
      routes: {
        AppRoutes.OnboardingScreen.name: (context) => OnboardingScreen(),
        AppRoutes.RegistrScreen.name: (context) => RegistrScreen(),
        AppRoutes.LoginScreen.name: (context) => LoginScreen(),
        AppRoutes.HomeScreen.name: (context) => HomeScreen(),
        AppRoutes.CreateEventScreen.name: (context) => CreateEventScreen(),
        AppRoutes.MapTab.name: (context) => MapTab(),
        AppRoutes.CompleteOnboardingScreen.name: (context) => CompleteOnboardingScreen(),
        AppRoutes.EventDetails.name: (context) => EventDetails(),

      },
    );
  }
}
