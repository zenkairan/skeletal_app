import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/widgets/ProductCard.dart';
import 'package:skeletal_app/src/widgets/ProfilePic.dart';
import 'package:skeletal_app/src/widgets/Paragraph.dart';
import 'package:skeletal_app/src/scenes/LeftDrawer.dart';

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
            ProfilePic(),
            Paragraph(
              textAlign: TextAlign.justify,
              text: 'scelerisque, metus ut accumsan lacinia, enim magna commodo eros, ' +
              'facilisis accumsan nisl libero in ipsum. Ut faucibus dolor nulla, nec pellentesque ipsum gravida nec.'+
              ' Nullam facilisis risus et ante elementum, id volutpat quam tristique. Donec mollis mollis ex,'+
              ' in maximus ex pulvinar vitae. Praesent consectetur mi ac mauris laoreet, eu bibendum ligula pellentesque.'+
              ' Cras ante purus, aliquet non ante nec, pretium varius nisi. Nullam auctor felis turpis, ac pellentesque elit egestas a.'+
              'Duis quis tristique eros. Vivamus posuere ornare mauris, pellentesque lobortis massa suscipit non. Etiam facilisis lacus nec mi consequat finibus.'+
              ' Aliquam egestas volutpat tincidunt. Donec eu nulla porta, pharetra tortor eget, posuere mauris. Vivamus enim est, bibendum ac metus non, malesuada semper sapien.'+
              ' Fusce dapibus, ante eget vehicula finibus, quam erat pulvinar leo, a fringilla lectus sapien quis est. Duis eu nunc metus.'+
              ' Fusce eu lacus sit amet nulla ullamcorper molestie a vitae nibh. Proin varius tincidunt turpis in pretium. Donec tincidunt quam nec quam congue, vitae lacinia mauris mollis.',
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