import 'package:flutter/material.dart';

import 'package:skeletal_app/src/Localization/CustomLocalizaton.dart';
import 'package:skeletal_app/src/widgets/BaseColors.dart';

/**
 * Widget que apresenta o card do produto do aplicativo, 
 * com o intuito de apresentar uma lista
 */
class ProductCard extends StatefulWidget{
  @override
  createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard>{

  @override
  Widget build(BuildContext context){
    return Center(
      child: Card(
          color: BaseColors.cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Product title', style: TextStyle(color: BaseColors.textColor),),
                subtitle: Text('Product Description', style: TextStyle(color: BaseColors.textColor),),
                onTap: () => Navigator.pushNamed(context, '/product'),
                trailing: Image.network(
                  'https://upload.wikimedia.org/wikipedia/en/b/bc/Archspire_Relentless_Mutation_Album_Artwork.jpg',
                  scale: 4.6,
                  ),
              ),
          ],
        ),
      )
    );
  }
}