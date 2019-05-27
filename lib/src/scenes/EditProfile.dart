import 'package:flutter/material.dart';
import 'dart:convert';


import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/CustomDialog.dart';
import 'package:skeletal_app/src/services/Connection.dart';
import 'package:skeletal_app/src/beans/User.dart';

/**
 * Edição de perfil de usuário
 */
class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {

  String _userDescription;
  final _formKey = GlobalKey<FormState>();
  UserSingleton loggedUser = new UserSingleton();
   BuildContext _innerContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).edit),
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
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: ProfilePic(url: (loggedUser.user != null)? loggedUser.user.picture: null),
              onPressed: () => print('Mudar foto'),//character sheet
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: CustomLocalization.of(context).userDescription, 
                    ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null, //overflowing screen
                  onSaved: (value) => _userDescription = value,
                  ),
                  RaisedButton(
                    child: Text(CustomLocalization.of(context).save),
                    onPressed: () {
                      _formKey.currentState.save();
                      loggedUser.user.about = _userDescription;
                      updateUser();
                    },
                  )
                ],
              ),
            ),
          ],
        )
    );
  }


  updateUser() async{
    try{
      CustomDialog.startProgressIndicatorModal(context);
      var response = await Connection.editUser(loggedUser.user.id, jsonEncode(loggedUser.user));
      CustomDialog.stopProgressIndicatorModal(context);
      if(response.statusCode == 200){
        if(response.body != null && response.body.isNotEmpty && response.body != 'null'){
          loggedUser.user = User.fromJason(json.decode(response.body));
          Navigator.pushReplacementNamed(context, '/index');
        }else{
          CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).userNotFound);
        }
      }else{
        if(response.statusCode == 404){
          CustomDialog.showSnackbar(_innerContext, CustomLocalization.of(_innerContext).userNotFound);
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