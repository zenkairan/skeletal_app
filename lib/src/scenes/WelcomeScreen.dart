import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/services/Connection.dart';

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
  UserSingleton loggedUser = new UserSingleton();
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
            RaisedButton(
              child: Text(CustomLocalization.of(context).facebook, style: TextStyle(color: BaseColors.textColor)),
              color: BaseColors.facebook,
              onPressed: () {
                initiateFacebookLogin();
                Navigator.pushNamed(context, '/index');
                },
            ),
            //test connection
            RaisedButton(
              child: Text('Test connection'),
              onPressed: (){
                getUser();
              },
              )
            //---------------
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
        
        onLoginStatusChanged(true, profileData: profile);
        _initFacebookUser(profile);
        break;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {dynamic profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

    //create user from facebook data
  void _initFacebookUser(dynamic profileData){
    User user = new User(profileData['name'], profileData['email'], null);
    user.facebookId = profileData['id'];
    user.picture = profileData['picture']['data']['url'];
    this.loggedUser.user = user;
  }

  Future getUser() async {
    print('test1');
    var response = await Connection.getUser('5ce076fa16b2eb6dbf5dbbae');
    print('test2');
    print(response.body);
    User user = User.fromJason(json.decode(response.body));
    print(user);
    print('json user: ' + json.encode(user));
  }

}