import 'package:flutter/material.dart';

import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';

class LeftDrawer extends StatefulWidget {

  @override
  createState() => LeftDrawerState();
}

class LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: BaseColors.bar,
        child: ListView(
          children: <Widget>[
            FlatButton(
              child: ProfilePic(height: 100.0, width: 100.0,),
              onPressed: () => print('edit profile'),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: FlatButton(
                child: Text(
                  CustomLocalization.of(context).home,
                  style: TextStyle(color: BaseColors.textColor,fontSize: 30.0,),
                ),
                onPressed: () => print('home'),
              ),
            )
          ],
        ),
      ),
    );
  }
}