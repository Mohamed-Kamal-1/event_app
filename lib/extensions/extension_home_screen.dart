import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

extension Apploacal on BuildContext{
  AppLocalizations? get appLocal => AppLocalizations.of(this);
}

extension AppTextTheme on BuildContext{
  TextTheme get  textTheme => Theme.of(this).textTheme;
}