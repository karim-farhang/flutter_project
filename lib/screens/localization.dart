import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default language is English
  Locale _locale = const Locale('en');

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizationsDelegate(), // Add custom delegate
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ps'), // Pashto
        Locale('fa'), // Dari
      ],
      home: MyHomePage(onLanguageChange: _changeLanguage),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(String) onLanguageChange;

  const MyHomePage({required this.onLanguageChange, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.title ?? 'Default Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)?.welcome ?? 'Welcome'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => onLanguageChange('en'),
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () => onLanguageChange('ps'),
              child: const Text('Pashto'),
            ),
            ElevatedButton(
              onPressed: () => onLanguageChange('fa'),
              child: const Text('Dari'),
            ),
          ],
        ),
      ),
    );
  }
}

// Localization class for string translations
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Multi-Language App',
      'welcome': 'Welcome to the App!',
    },
    'ps': {
      'title': 'د څو ژبو اپلیکیشن',
      'welcome': 'د اپلیکیشن ته ښه راغلاست!',
    },
    'fa': {
      'title': 'برنامه چند زبانه',
      'welcome': 'به برنامه خوش آمدید!',
    },
  };

  String? get title => _localizedValues[locale.languageCode]?['title'];
  String? get welcome => _localizedValues[locale.languageCode]?['welcome'];
}

// Delegate for app localization
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ps', 'fa'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
