import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Localization/english.dart';
import 'package:xpressfly_git/Localization/hindi.dart';

class LocalizationService extends Translations {
  static var locale = Locale("en", "EN");
  static const fallbackLocale = Locale("en", "EN"); // Changed from "tr" to "en"
  static final language = ["English", "Hindi"];
  static final locales = [const Locale("en", "EN"), const Locale("hi", "HI")];

  @override
  Map<String, Map<String, String>> get keys => {
    'hi_HI': Hindi,
    'en_EN': English,
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    log(locale.toString());
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      debugPrint("You selected : ${language[i]}");
      if (lang == language[i]) {
        log(language[i]);
        log(lang);
        // PrefService.setValue("language", language[i]);
        return locales[i];
      }
    }
    return Get.locale;
  }
}
