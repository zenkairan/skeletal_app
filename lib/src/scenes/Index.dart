import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/beans/Product.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProductCard.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/widgets/Paragraph.dart';
import 'package:skeletal_app/src/scenes/LeftDrawer.dart';
import 'package:skeletal_app/src/singletons/UserSingleton.dart';
import 'package:skeletal_app/src/services/Connection.dart';

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
      child: FutureBuilder(
        future: _getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView(
              children: snapshot.data,
            );
          }else{
            return ListView(
              children: <Widget>[
                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            );
          }
        },
      ) 
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
    return Center(
      child: RaisedButton(
        child: Text('Log navigator'),
        onPressed: () => print(Navigator.of(context)),
      ),
    );
  }

//TODO: paginação
  Future<List<Widget>> _getProducts() async{
    var response = await Connection.getProducts();
    List<Widget> productCards = new List<Widget>();
    if(response.statusCode == 200){
      List<dynamic> productsJson = jsonDecode(response.body)['docs'];
      productsJson.forEach((productJson){
        productCards.add(new ProductCard(Product.fromJson(productJson)));
      });
    }else{
      productCards.add(new Center(
        child: Text(CustomLocalization.of(context).noProducts, style: TextStyle(fontSize: 20),),
      ));
    }
    return productCards;
  }
  _downloadProducts(){
    return _getProducts();
  }
}