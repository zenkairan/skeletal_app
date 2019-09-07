import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  List<Widget> _products;
  int page = 1;
  int totalPages = 1;

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

   @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
    return NotificationListener(
    child: RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () =>_downloadProducts(),
      child: ListView(
          children: _products != null? _products:
            <Widget>[
              Container(
                child: Center(
              //TODO: Circular progress ficou muito grande
                  child: CircularProgressIndicator(),
                ),
              )
          ],
          controller: scrollController,
        ),
      ), 
      onNotification: _onNotification,
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
//TODO: busca por nome
  Future<List<Widget>> _getProducts() async{
    var response;
    if(this.page == 1){
      response = await Connection.getProducts();
    } else{
      print('page: ' + this.page.toString());
      response = await Connection.getProducts(page: this.page);
    }
    List<Widget> productCards = new List<Widget>();
    if(response.statusCode == 200){
      List<dynamic> productsJson = jsonDecode(response.body)['docs'];
      productsJson.forEach((productJson){
        productCards.add(new ProductCard(Product.fromJson(productJson)));
      });
      print(Product.fromJson(productsJson.first));
      var pages = jsonDecode(response.body)['pages'];
      if(pages != null){
        this.totalPages = pages;
      }
    }else{
      productCards.add(new Center(
        child: Text(CustomLocalization.of(context).noProducts, style: TextStyle(fontSize: 20),),
      ));
    }
    setState(() {
      if(this.page == 1){
        _products = productCards;
      }else{
        //por algum motivo só aparece depois de recarregar a página
        _products.addAll(productCards);
      }
      print(_products.length);
    });
    return productCards;
  }
  Future<void> _downloadProducts() async{
    setState(() {
      this.page = 1;
      _products = null;
      //products é setado novamente para null para que apareça o
      //CircularProgressIndicator
    });
     _getProducts();
     return null;
  }

  //se a lista inicial for muito pequena, nunca haverá notificação
  //load more button é mais simples e melhor usabilidade
  bool _onNotification(ScrollNotification notification) {
    if(notification is ScrollUpdateNotification){
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
        scrollController.position.maxScrollExtent - scrollController.offset <= 50 &&
        scrollController.position.userScrollDirection == ScrollDirection.reverse){
          //deve evitar fazer carregamentos multiplos
          print(scrollController.position.userScrollDirection);
          if(this.page < this.totalPages){
            this.page += 1;
            _getProducts();
          }
        } 
    }
    return true;
  }
}