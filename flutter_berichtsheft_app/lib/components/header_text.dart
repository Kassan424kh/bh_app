import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsets margin;

  HeaderText({
    Key key,
    this.text,
    this.fontSize = 20,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;

    return Container(
      margin: margin,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: _selectedTheme[ElementStylingParameters.headerTextColor], fontSize: fontSize),
        textAlign: TextAlign.left,
      ),
    );
  }
}
