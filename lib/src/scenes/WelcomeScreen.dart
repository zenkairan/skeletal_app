import 'package:flutter/material.dart';

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
            )
          ],
        ),
      ),
    );
  }
}