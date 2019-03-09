import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';

class ProductDetail extends StatefulWidget{
  @override
  createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalization.of(context).product),
        backgroundColor: BaseColors.bar,
      ),
      body: _renderProduct(),
      backgroundColor: BaseColors.background,
    );
  }

  Widget _renderProduct(){
    return Text('test');
  }
}