import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';

/**
 * tela com opções para login e cadastro.
 * Identifica se o usuário já está logado, Nesse caso, redireciona
 * para página inicial
 */
class WelcomeScreen extends StatefulWidget{
  @override
  createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> with RouteAware{

  bool isLoggedIn = false;
  dynamic profileData = null;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).welcome),
        backgroundColor: BaseColors.bar,
      ),
      body: _renderPage(context), //future builder
      backgroundColor: BaseColors.background,
    );
  }

  Widget _renderPage(BuildContext context){
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              CustomLocalization.of(context).welcomeMessage,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, wordSpacing: 5, color: BaseColors.defaltTxtColor),
              ),
            RaisedButton(
              child: Text(CustomLocalization.of(context).login, style: TextStyle(color: BaseColors.textColor),),
              color: BaseColors.buttonColor,
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
            RaisedButton(
              child: Text(CustomLocalization.of(context).register, style: TextStyle(color: BaseColors.textColor),),
              color: BaseColors.buttonColor,
              onPressed: () => Navigator.pushNamed(context, '/register'),
            ),
            isLoggedIn
                ? Text("Logged In")
                : RaisedButton(
                    child: Text("Login with Facebook"),
                    onPressed: () => initiateFacebookLogin(),
                  ),
          ],
        ),
      ),
    );
  }

  //facebook handling
  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print(facebookLoginResult.errorMessage);
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");
        
        var graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${facebookLoginResult
        .accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        
        onLoginStatusChanged(true, profileData: profile);
        _initFacebookUser(profileData);
        break;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {dynamic profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void _initFacebookUser(dynamic profileData){
    //create user from facebook data
  }

}