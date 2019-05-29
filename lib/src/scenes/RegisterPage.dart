import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/beans/User.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/Connection.dart';
import 'package:skeletal_app/src/services/CustomDialog.dart';
import 'package:skeletal_app/src/services/FileManager.dart';


/**
 * Formulário de cadastro. Ao concluir redireciona
 * para uma pagina Stepper que ira precedir a pagina inicial
 */
class RegisterPage extends StatefulWidget{
  @override
  createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage>{
  
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  UserSingleton appUser = new UserSingleton();
  BuildContext _innerContext;


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).register),
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
              initialValue: _name,
              maxLength: 15,
              decoration: InputDecoration(
                labelText: CustomLocalization.of(context).userName
              ),
              validator: (value){
                if(value.isEmpty)
                  return CustomLocalization.of(context).userNameRequired;
              },
              onSaved: (value) => _name = value,
            ),
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
                    saveUser();
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

  Future saveUser() async{
    try{
      CustomDialog.startProgressIndicatorModal(context);
      User newUser = new User(_name, _email, _password);
      var response = await Connection.postUser(json.encode(newUser));
      CustomDialog.stopProgressIndicatorModal(context);
      //se o usuario já estiver cadastrado, retornar statuscode de erro
      if(response.statusCode == 200){
        appUser.user = User.fromJason(json.decode(response.body));
        FileManager.writeUser(json.encode(appUser.user));
        Navigator.of(context).pushNamedAndRemoveUntil('/index', (Route<dynamic> route) => false);
      }else{
        CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).connectionError);
      }
    }catch(e, stackTrace){
      CustomDialog.stopProgressIndicatorModal(context);
      print(stackTrace);
      CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).defaultError);
    }
  }
}