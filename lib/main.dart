import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/scenes/WelcomeScreen.dart';
import 'package:skeletal_app/src/scenes/LoginPage.dart';
import 'package:skeletal_app/src/scenes/RegisterPage.dart';
import 'package:skeletal_app/src/scenes/Index.dart';
import 'package:skeletal_app/src/scenes/ProductDetail.dart';

void main(){

  runApp(
    MaterialApp(
      home: WelcomeScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
        '/index': (BuildContext context) => Index(),
        '/product': (BuildContext context) => ProductDetail(),
      },
      localizationsDelegates: [
        const CustomLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), //English
        const Locale('pt', 'BR'), //Brasil
      ],
    )
  );
}

