import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/beans/Product.dart';

class ProductDetail extends StatefulWidget{
  ProductDetail(this.product);
  final Product product;
  @override
  createState() => ProductDetailState(product);
}

class ProductDetailState extends State<ProductDetail>{
  ProductDetailState(this.product);
  Product product;
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
    return Text(product.toString());
  }
}