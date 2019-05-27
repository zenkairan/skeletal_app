import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/Connection.dart';
import 'package:skeletal_app/src/services/CustomDialog.dart';

/**
 * Formulário de login, após login validado redireciona
 * para página inicial
 */
class LoginPage extends StatefulWidget{
  @override
  createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{
  
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  UserSingleton appUser = new UserSingleton();
  BuildContext _innerContext;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).login),
        backgroundColor: BaseColors.bar,
      ),
      body: Builder(
        //builder é criado ao invés de retornar _loginForm diretamente para criar
        //um Buildcontext filho do Buildcontext global da página,
        //para poder usar Scaffold.of() dentro dos wigdets 
        builder: (BuildContext context){
          _innerContext = context;
          return _loginForm(context);
        },
      ),
      backgroundColor: BaseColors.background,
    );
  }

  Widget _loginForm(BuildContext context){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              initialValue: _email,
              maxLength: 15,
              decoration: InputDecoration(
                labelText: CustomLocalization.of(context).email
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if(value.isEmpty)
                  return CustomLocalization.of(context).emailRequired;
              },
              onSaved: (value) => _email = value,
            ),
            TextFormField(
              initialValue: _password,
              maxLength: 15,
              decoration: InputDecoration(
                labelText: CustomLocalization.of(context).password
              ),
              obscureText: true,
              validator: (value){
                if(value.isEmpty)
                  return CustomLocalization.of(context).passwordRequired;
              },
              onSaved: (value) => _password = value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    _formKey.currentState.save();
                    login();
                  }else{
                    print('invalid inputs');
                  }
                },
                color: BaseColors.buttonColor,
                child: Text(CustomLocalization.of(context).send, style: TextStyle(color: BaseColors.textColor),),
              ),
            )
          ],
        ),
      ),
    );
  }


  login() async{
    try{
      CustomDialog.startProgressIndicatorModal(context);
      var response = await Connection.logIn(_email, _password);
      CustomDialog.stopProgressIndicatorModal(context);
      if(response.statusCode == 200){
        if(response.body != null && response.body.isNotEmpty && response.body != 'null'){
          appUser.user = User.fromJason(json.decode(response.body));
          Navigator.of(context).pushNamedAndRemoveUntil('/index', (Route<dynamic> route) => false);
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