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

  @override
    void initState() {
      print(url);
      super.initState();
      if(heigth == null)
        this.heigth = 120.0;
      if(width == null)
        this.width = 120.0;
      if(this.url == null || this.url.isEmpty){
        this.url = 'assets/profilepic_placeholder.png';
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
        border: Border.all(width: 8, color: BaseColors.borderColor),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: FadeInImage.assetNetwork(
          fit: BoxFit.fill,
          image: this.url,
          height: this.heigth,
          width: this.width,
          placeholder: 'assets/profilepic_placeholder.png',
        ),
      ),
    );
  }
}