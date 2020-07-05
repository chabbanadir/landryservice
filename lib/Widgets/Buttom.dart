import 'package:flutter/material.dart';

class Buttoms extends StatelessWidget {
  final Icon iconButton;
  final Function onPressed;
  double iconSize;


  Buttoms({this.iconButton,this.onPressed,this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Ink(
          padding: EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent
                ]
            ),
            color: Colors.lightBlue,
          ),
          child: IconButton(
            iconSize: iconSize,
            icon: iconButton,
            color: Colors.white,
            // ignore: unnecessary_statements
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}