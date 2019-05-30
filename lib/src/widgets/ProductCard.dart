import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';
import 'package:skeletal_app/src/beans/Product.dart';

/**
 * Widget que apresenta o card do produto do aplicativo, 
 * com o intuito de apresentar uma lista
 */
class ProductCard extends StatefulWidget{
  ProductCard(this.product);
  final Product product;
  @override
  createState() => ProductCardState(product);
}

class ProductCardState extends State<ProductCard>{
  ProductCardState(this.product);
  Product product;

  @override
  Widget build(BuildContext context){
    return Center(
      child: Card(
          color: BaseColors.cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(product.title, style: TextStyle(color: BaseColors.textColor),),
                subtitle: Text(product.description, style: TextStyle(color: BaseColors.textColor),),
                onTap: () => Navigator.pushNamed(context, '/product'),
                trailing: Image.network(
                  product.url,
                  scale: 4.6,
                  ),
              ),
          ],
        ),
      )
    );
  }
}