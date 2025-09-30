import 'package:evently_app/SharedPreferences/app_shared_preferences.dart';
import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/onboarding_screen.dart';
import 'package:evently_app/ui/register/registr_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await AppSharedPreferences.init();

   runApp(MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
      ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: MainApp())



  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppLanguageProvider appLanguageProvider = Provider.of<AppLanguageProvider>(context,);
    AppThemeProvider appThemeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:appThemeProvider.getSelectedThemMode() ,
      locale: Locale(appLanguageProvider.getAppLanguage()),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: AppRoutes.RegistrScreen.route,
      routes: {
        AppRoutes.OnboardingScreen.route : (context) => OnboardingScreen(),
        AppRoutes.RegistrScreen.route : (context) => RegistrScreen(),
      },
    );
  }
}



