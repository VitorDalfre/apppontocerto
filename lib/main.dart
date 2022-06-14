import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pontocerto/global.dart';
import 'package:pontocerto/splashScreen.dart';
import 'provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    gProviderNotifier = ProviderNotifier();
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.orange, selectionHandleColor: Colors.orange),
        fontFamily: 'Arial',
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          secondary: Colors.orange,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
