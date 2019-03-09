import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';


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


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).register),
        backgroundColor: BaseColors.bar,
      ),
      body: _loginForm(context),
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
                    print('saved');
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/index');
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
}