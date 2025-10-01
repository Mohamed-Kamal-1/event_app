import 'package:flutter/cupertino.dart';
import '../../../l10n/app_localizations.dart';

final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

String? validationInputNameAndPhone(String? name, BuildContext context) {
  if (isInputEmpty(name)) {
    return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.name}';
  }
  return null;
}

String? validationInputEmail(String? email, BuildContext context) {
  if (isInputEmpty(email)) {
    return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.email}';
  }

  if (!emailRegex.hasMatch(email!)) {
    return '${AppLocalizations.of(context)!.pleaseEnterValid} ${AppLocalizations.of(context)!.email}';
  }
  return null;
}

String? validationInputPassword(String? password, BuildContext context) {
  if (isInputEmpty(password)) {
    return '${AppLocalizations.of(context)!.pleaseEnter} ${AppLocalizations.of(context)!.password}';
  }
  if (password!.length < 6) {
    return AppLocalizations.of(context)!.passwordMust6Char;
  }
  return null;
}

String? validationInputRePassword(
    String? rePassword,
    BuildContext context, {
      String? passwordController,
    }) {
  if (isInputEmpty(rePassword)) {
    return '${AppLocalizations.of(context)!.rePassword}';
  }
  if (rePassword!.length < 6) {
    return '${AppLocalizations.of(context)!.pleaseEnterValid} ${AppLocalizations.of(context)!.rePassword}';
  }
  if (passwordController != rePassword) {
    return AppLocalizations.of(context)!.passwordsDoesNotMatch;
  }
  return null;
}

bool isInputEmpty(String? userInput) {
  return userInput?.trim().isEmpty == true;
}
