// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get personalizeYourExperience => 'خصص تجربتك';

  @override
  String get personalizeDescription =>
      'اختر اللغة والمظهر المفضلين لديك للبدء بتجربة مريحة ومصممة لتناسب ذوقك.';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get letsStart => 'هيا نبدأ';
}
