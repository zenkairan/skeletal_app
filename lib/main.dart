import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/scenes/WelcomeScreen.dart';
import 'package:skeletal_app/src/scenes/LoginPage.dart';
import 'package:skeletal_app/src/scenes/RegisterPage.dart';
import 'package:skeletal_app/src/scenes/Index.dart';
import 'package:skeletal_app/src/scenes/ProductDetail.dart';
import 'package:skeletal_app/src/scenes/EditProfile.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/FileManager.dart';

void main() async{
  UserSingleton loggedUser = new UserSingleton();
  String userString = await FileManager.readUser();
  if(userString != null){
    loggedUser.user = User.fromJason(json.decode(userString));
    //check user with api
  }
  runApp(
    MaterialApp(
      home: loggedUser.user != null? Index(): WelcomeScreen(),
      routes: <String, WidgetBuilder>{
        '/welcome': (BuildContext context) => WelcomeScreen(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
        '/index': (BuildContext context) => Index(),
        // '/product': (BuildContext context) => ProductDetail(),
        '/edit': (BuildContext context) => EditProfile(),
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

