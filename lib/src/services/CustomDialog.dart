import 'package:flutter/material.dart';

class CustomDialog{

  static bool isModalActive = false;

  static void startProgressIndicatorModal(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return Dialog(
            child: Center(
              heightFactor: 0, //remove janela branca de fundo
              child: CircularProgressIndicator(),
            ),
          );
      }
    );
    isModalActive = true;
  }
  static void stopProgressIndicatorModal(BuildContext context){
    if(isModalActive){
        Navigator.pop(context); //pop modal
      }
  }

  static void showSnackbar(BuildContext context, String msg){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}