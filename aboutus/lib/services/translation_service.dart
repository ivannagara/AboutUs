import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationService extends Translations {
  static final locale = _getLocaleFromLanguage();
  static const fallbackLocale = Locale('en', 'US');
  
  // Supported languages
  static final languages = [
    'en_US',
    'es_ES',
    'fr_FR',
  ];
  
  // Supported locales
  static final locales = [
    const Locale('en', 'US'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
  ];
  
  // Keys and translations
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'appTitle': 'AboutUs',
      'tapDeck': 'Tap the deck to draw a card',
      'swipeCard': 'Swipe to dismiss',
    },
    'es_ES': {
      'appTitle': 'Sobre Nosotros',
      'tapDeck': 'Toca el mazo para sacar una carta',
      'swipeCard': 'Desliza para descartar',
    },
    'fr_FR': {
      'appTitle': 'À Propos De Nous',
      'tapDeck': 'Touchez le paquet pour tirer une carte',
      'swipeCard': 'Balayez pour rejeter',
    },
  };
  
  // Gets locale from language (stored in shared preferences)
  static Locale _getLocaleFromLanguage([String? language]) {
    language ??= getLanguageCode();
    
    for (int i = 0; i < languages.length; i++) {
      if (language == languages[i]) return locales[i];
    }
    return fallbackLocale;
  }
  
  static String getLanguageCode() {
    final prefs = Get.find<SharedPreferences>();
    String? languageCode = prefs.getString('language');
    
    if (languageCode == null) {
      return Get.deviceLocale?.toString() ?? 'en_US';
    }
    
    return languageCode;
  }
  
  static void changeLocale(String languageCode) {
    final prefs = Get.find<SharedPreferences>();
    final locale = _getLocaleFromLanguage(languageCode);
    
    prefs.setString('language', languageCode);
    Get.updateLocale(locale);
  }
  
  Future<TranslationService> init() async {
    await Get.putAsync<SharedPreferences>(() async {
      return await SharedPreferences.getInstance();
    });
    return this;
  }
}