import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProductCard.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/widgets/Paragraph.dart';
import 'package:skeletal_app/src/scenes/LeftDrawer.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';

/**
 * Página inicial, contendo abas e menu lateral
 */
class Index extends StatefulWidget{
  @override
  createState() => IndexState();
}

class IndexState extends State<Index>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();
  UserSingleton loggedUser = new UserSingleton();

  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.account_balance),),
              Tab(icon: Icon(Icons.account_box),),
              Tab(icon: Icon(Icons.account_balance_wallet),),
            ],
          ),
          title: Text(CustomLocalization.of(context).home),
          backgroundColor: BaseColors.bar,
        ),
        body: TabBarView(
          children: <Widget>[
            _tab1(context),
            _tab2(context),
            _tab3(context),
          ],
        ),
        backgroundColor: BaseColors.background,
        drawer: LeftDrawer(),
      ),
    ); 
    
  }

  Widget _tab1(BuildContext context){
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () =>_downloadProducts(),
      child: ListView(
        children: _getProducts(),
      ),
    );
  }

  Widget _tab2(BuildContext context){
    return SingleChildScrollView(
      child:Center(
        child: Column(
          children: <Widget>[
            ProfilePic(height: 100.0, width: 100.0, url: (loggedUser.user != null)? loggedUser.user.picture: null,),
            Paragraph(
              textAlign: TextAlign.justify,
              text: loggedUser.user != null && loggedUser.user.about != null? loggedUser.user.about: '',
            ),
          ],
        ),
      )
    );
  }

  Widget _tab3(BuildContext context){
    return Text('tab3');
  }

  List<Widget> _getProducts(){
    print('getting producst');
    return [
      ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
        ProductCard(),
    ];
  }
  _downloadProducts(){
    return _getProducts();
  }
}