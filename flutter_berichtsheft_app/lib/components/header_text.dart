import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class HeaderText extends StatelessWidget {
  final String text;

  HeaderText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Styling.lightTheme[Elements.headerText],
        fontSize: 20
      ),
      textAlign: TextAlign.left,
    );
  }
}
