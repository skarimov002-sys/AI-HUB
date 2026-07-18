// Copyright (c) 2026 Sanjar Karimjonov. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() =>
      ['en', 'ru', 'tr', 'ar', 'fr', 'zh_Hant', 'ja'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? ruText = '',
    String? trText = '',
    String? arText = '',
    String? frText = '',
    String? zh_HantText = '',
    String? jaText = '',
  }) =>
      [
        enText,
        ruText,
        trText,
        arText,
        frText,
        zh_HantText,
        jaText
      ][languageIndex] ??
      '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Onboarding
  {
    'eckc6c94': {
      'en': 'Nexus AI Hub',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'vbzp5swc': {
      'en': 'Your unified gateway to the world\'s most powerful intelligence.',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'v40298z8': {
      'en': 'Select Default Model',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'ed08cblx': {
      'en': 'API Configuration',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'mlglxeis': {
      'en': 'Keys are stored locally on your device.',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // MainChatInterface
  {
    'yy24xu8y': {
      'en': 'Nexus AI Hub',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '041hn6js': {
      'en': 'Anthropic · Claude 3.5 Sonnet',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'cwfjtors': {
      'en': 'AR',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '8027jfll': {
      'en': 'Compare Models',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'noyfn8gf': {
      'en':
          'Run this prompt across all active models to see differences in real-time.',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'vzgjj2k4': {
      'en': 'Web Search',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'bcl55nuv': {
      'en': 'Code Interpreter',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '52elg7rl': {
      'en': '2,450 tokens remaining',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // ModelComparison
  {
    'jotk8ktr': {
      'en': 'Model Comparison',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '0yhmop7u': {
      'en': 'Explain the concept of quantum entanglement to a five-year-old.',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'uceymics': {
      'en': 'Claude',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '17f1o7sn': {
      'en': 'GPT-4',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'bdaw44sb': {
      'en': 'Gemini',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // ChatHistory
  {
    'wuc7qcde': {
      'en': 'Chat History',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'erv4s5wy': {
      'en': 'Manage your AI conversations',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'rlz8hogx': {
      'en': 'TODAY',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'b7mkonhu': {
      'en': 'YESTERDAY',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'c7o5pyfv': {
      'en': 'LAST WEEK',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // APISettings
  {
    'p3d9q88q': {
      'en': 'API Credentials',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'wc74yrvo': {
      'en': 'Manage your AI provider integrations',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'gouiskni': {
      'en': 'Nexus AI Hub uses your own keys',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'q7gk6q57': {
      'en':
          'Keys are stored locally on your device and never sent to our servers.',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'hsvc9puu': {
      'en': 'Advanced Options',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // ThemePersonalization
  {
    'd2s6cjto': {
      'en': 'Theme & Personalization',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'w008db1e': {
      'en': 'Live Preview',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'vutx9rk7': {
      'en': 'NX',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'a9w141ix': {
      'en': 'ME',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'p58herq2': {
      'en': 'Orange Intensity',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'sjgm7j3t': {
      'en': 'Vibrant',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'n8t6es9k': {
      'en': 'Interface Density',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '6hy17tq4': {
      'en': 'Model Identity Accents',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // ModelResponseCard
  {
    'vuggqo0c': {
      'en': '1.2s',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // ApiCard
  {
    'nw1hzvpw': {
      'en': 'API Configuration',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
  // Miscellaneous
  {
    'ibln5f8t': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'vn1qq49v': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '2ujnjpjp': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'qmvzktln': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '0mhn4240': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'jtoivnom': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'ryo39hj1': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'ns44ckeb': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'ag09s68s': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'tsca7rjj': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'nvsk4nfd': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'o38eu2qm': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'mfr9l7wr': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '2iqxq5d8': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '242x80id': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'gymixwsa': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'one2lyif': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '2z9hxmsv': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    '5opf291u': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'cl0n91ld': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'cyjj1y0o': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'lpn7twxv': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'r0ohsv09': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'wcj7lre2': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
    'p21o0flo': {
      'en': '',
      'ar': '',
      'fr': '',
      'ja': '',
      'ru': '',
      'tr': '',
      'zh_Hant': '',
    },
  },
].reduce((a, b) => a..addAll(b));
