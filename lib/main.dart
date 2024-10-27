import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackizer/common/color_extension.dart';
import 'package:trackizer/entities/CreditCard.dart';
import 'package:trackizer/entities/Subscription.dart';
import 'package:trackizer/providers/locale_provider.dart';
import 'package:trackizer/services/CreditCardService.dart';
import 'package:trackizer/services/SubscriptionService.dart';
import 'package:trackizer/view/login/welcome_view.dart';
import 'package:trackizer/Enum/SubscriptionType.dart';
import 'package:trackizer/generated//l10n.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, value, child) => MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,

        locale: value.current,
        title: 'SubTrack',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          colorScheme: ColorScheme.fromSeed(
              seedColor: TColor.primary,
              background: TColor.gray80,
              primary: TColor.primary,
              primaryContainer: TColor.gray60,
              secondary: TColor.secondary),
          useMaterial3: false,
        ),
        home: const WelcomeView(), // WelcomeView
      ),
    );
  }
}
