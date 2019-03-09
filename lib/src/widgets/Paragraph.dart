import 'package:flutter/material.dart';

import 'package:skeletal_app/src/widgets/BaseColors.dart';

class Paragraph extends StatefulWidget {
  Paragraph({this.alignment = Alignment.center, this.textAlign = TextAlign.center, @required this.text});
  final Alignment alignment;
  final TextAlign textAlign;
  final String text;
  createState() => ParagraphState(alignment: alignment, text: text, textAlign: textAlign);
}

class ParagraphState extends State<Paragraph> {
  ParagraphState({this.alignment, this.textAlign, @required this.text});
  Alignment alignment;
  TextAlign textAlign;
  String text;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(this.text, textAlign: this.textAlign, style: TextStyle(color: BaseColors.defaltTxtColor),),
    );
  }
}