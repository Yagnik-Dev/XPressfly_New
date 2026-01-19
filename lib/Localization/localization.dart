import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
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

  // Load saved language preference
  static Locale getSavedLocale() {
    final savedLanguage = GetStorage().read(selectedLanguage);
    if (savedLanguage != null) {
      if (savedLanguage == "Hindi") {
        locale = const Locale("hi", "HI");
        return locale;
      } else if (savedLanguage == "English") {
        locale = const Locale("en", "EN");
        return locale;
      }
    }
    // Default to English if no preference is saved
    locale = const Locale("en", "EN");
    return locale;
  }

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    // Save the language preference
    GetStorage().write(selectedLanguage, lang);
    LocalizationService.locale = locale;
    log(locale.toString());
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      debugPrint("You selected : ${language[i]}");
      if (lang == language[i]) {
        log(language[i]);
        log(lang);
        return locales[i];
      }
    }
    return Get.locale;
  }
}
