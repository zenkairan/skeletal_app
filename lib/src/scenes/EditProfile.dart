import 'package:flutter/material.dart';


import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';

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
    return Center( 
      child: Column(
        children: <Widget>[
          FlatButton(
            child: ProfilePic(),
            onPressed: () => print('Mudar foto'),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('data') //TEXTFORMFIELD FOR TEXTAREA???????
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}