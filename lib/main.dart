import 'package:arya/language/app_translations_delegate.dart';
import 'package:arya/language/application.dart';
import 'package:arya/start_up/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  runApp(LocalisedApp());
}

class LocalisedApp extends StatefulWidget {
  @override
  LocalisedAppState createState() {
    return new LocalisedAppState();
  }
}

class LocalisedAppState extends State<LocalisedApp> {

  late AppTranslationsDelegate _newLocaleDelegate;

  @override
  Widget build(BuildContext context) {

    _newLocaleDelegate = AppTranslationsDelegate(newLocale: const Locale('en'));
    application.onLocaleChanged = onLocaleChange;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale("en", ""), const Locale("es", "")],
    );
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}