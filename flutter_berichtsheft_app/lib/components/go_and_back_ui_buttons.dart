import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class GoAndBackUiButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    TextStyle textStyle = TextStyle(
      color: _selectedTheme[ElementStylingParameters.headerTextColor],
      fontSize: 20,
      fontWeight: FontWeight.w300
    );
    return Container(
      padding: EdgeInsets.only(right: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            child: Text(
              "Back",
              style: textStyle,
            ),
            onPressed: () {},
            splashColor: _selectedTheme[ElementStylingParameters.primaryColor],
          ),
          FlatButton(
            child: Text(
              "Go",
              style: textStyle,
            ),
            onPressed: () {},
            splashColor: _selectedTheme[ElementStylingParameters.primaryColor],
          ),
        ],
      ),
    );
  }
}
