import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/Connection.dart';

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


  Future login() async{
    print(_email + ' ' + _password);
    bool isModalUp = false;
    try{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Dialog(
              child: Center(//janela branca muito grande
                child: CircularProgressIndicator(),
              ),
            );
        }
      );
      isModalUp = true;
      var response = await Connection.logIn(_email, _password);
      Navigator.pop(context); //pop modal
      isModalUp = false;
      if(response.statusCode == 200){
        if(response.body != null && response.body.isNotEmpty && response.body != 'null'){
          appUser.user = User.fromJason(json.decode(response.body));
          print(appUser.user);
          if(isModalUp){
            Navigator.pop(context);
          }
          Navigator.pushReplacementNamed(context, '/index');
        }else{
          //make a service for snackbar
          var snackbar = SnackBar(content: Text(CustomLocalization.of(_innerContext).loginError),);
          Scaffold.of(_innerContext).showSnackBar(snackbar);
        }
      }else{
        var snackbar;
        if(response.statusCode == 404){
          snackbar = SnackBar(content: Text(CustomLocalization.of(_innerContext).loginError),);
        }else{
          snackbar = SnackBar(content: Text(CustomLocalization.of(_innerContext).connectionError),);
        }
        Scaffold.of(_innerContext).showSnackBar(snackbar);
      }
    }catch(e, stackTrace){
      if(isModalUp){
        Navigator.pop(context); //pop modal
      }
      print(stackTrace);
      var snackbar = SnackBar(content: Text(CustomLocalization.of(_innerContext).defaultError),);
      Scaffold.of(_innerContext).showSnackBar(snackbar);
    }
  }
}