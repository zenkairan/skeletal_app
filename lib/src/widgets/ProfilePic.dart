import 'package:flutter/material.dart';

import 'package:skeletal_app/src/widgets/BaseColors.dart';

class ProfilePic extends StatefulWidget{
  ProfilePic({this.url, this.height, this.width});
  final String url;
  final double height;
  final double width;

  @override
  createState() => ProfilePicState(url: url, heigth: height, width: width);
}

class ProfilePicState extends State<ProfilePic>{
  ProfilePicState({this.url, this.heigth, this.width});
  String url;
  double heigth = 120.00;
  double width = 120.00;
  ImageProvider _imagem;

  @override
    void initState() {
      super.initState();
      if(heigth == null)
        this.heigth = 120.0;
      if(width == null)
        this.width = 120.0;
      if(this.url == null || this.url.isEmpty){
        this._imagem = new AssetImage(
          'assets/profilepic_placeholder.png',
        );
      }else{
        this._imagem = new NetworkImage(
          this.url,
          );
      }
    }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      height: this.heigth,
      width: this.width,
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 5, color: BaseColors.borderColor),
        image: DecorationImage(
          image: this._imagem,
          fit: BoxFit.fill
        )
      ),
    );
  }
}