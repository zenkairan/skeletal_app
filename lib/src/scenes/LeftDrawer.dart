import 'package:flutter/material.dart';

import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/FileManager.dart';

class LeftDrawer extends StatefulWidget {

  @override
  createState() => LeftDrawerState();
}

class LeftDrawerState extends State<LeftDrawer> {

  UserSingleton loggedUser = new UserSingleton();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: BaseColors.bar,
        child: ListView(
          children: <Widget>[
            FlatButton(
              child: ProfilePic(height: 100.0, width: 100.0, url: (loggedUser.user != null)? loggedUser.user.picture: null,),
              onPressed: () => Navigator.pushNamed(context, '/edit'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      CustomLocalization.of(context).home,
                      style: TextStyle(color: BaseColors.textColor,fontSize: 30.0,),
                    ),
                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/index', (Route<dynamic> route) => false),
                  ),
                  FlatButton(
                    child: Text(
                      CustomLocalization.of(context).logout,
                      style: TextStyle(color: BaseColors.textColor,fontSize: 30.0,),
                    ),
                    onPressed: () {
                      loggedUser.user = null;
                      FileManager.deleteUser();
                      Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}