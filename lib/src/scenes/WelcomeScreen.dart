import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/services/Connection.dart';
import 'package:skeletal_app/src/services/CustomDialog.dart';

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
  BuildContext _innerContext;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).welcome),
        backgroundColor: BaseColors.bar,
      ),
      body: Builder(
        //builder é criado ao invés de retornar _loginForm diretamente para criar
        //um Buildcontext filho do Buildcontext global da página,
        //para poder usar Scaffold.of() dentro dos wigdets 
        builder: (BuildContext context){
          _innerContext = context;
          return _renderPage(context);
        },
      ),
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
    _facebookLogin(user);
  }

  _facebookLogin(User user) async {
    try{
      CustomDialog.startProgressIndicatorModal(context);
      var response = await Connection.loginFacebook(json.encode(user));
      CustomDialog.stopProgressIndicatorModal(context);
      if(response.statusCode == 200){
        if(response.body != null && response.body.isNotEmpty && response.body != 'null'){
          loggedUser.user = User.fromJason(json.decode(response.body));
          Navigator.pushReplacementNamed(context, '/index');
        }else{
          CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).loginError);
        }
      }else{
        if(response.statusCode == 404){
          CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).loginError);
        }else{
          CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).connectionError);
        }
      }
    }catch(e, stackTrace){
      CustomDialog.stopProgressIndicatorModal(context);
      print(stackTrace);
      CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).defaultError);
    }
  }

}