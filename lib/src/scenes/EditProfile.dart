import 'package:flutter/material.dart';


import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).edit),
        backgroundColor: BaseColors.bar,
      ),
      body: _renderPage(context),
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
                  ),
                  RaisedButton(
                    child: Text(CustomLocalization.of(context).save),
                    onPressed: () => print('saved'),
                  )
                ],
              ),
            ),
          ],
        )
    );
  }
}