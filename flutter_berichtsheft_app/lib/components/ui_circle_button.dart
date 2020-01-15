import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class UICircleButton extends StatelessWidget{
  final onPressed;

  UICircleButton({Key key , this.onPressed}): super(key:key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;

    return Container(
      width: 50,
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: onPressed,
          color: _selectedTheme[ElementStylingParameters.headerTextColor],
          highlightColor: _selectedTheme[ElementStylingParameters.boxShadowColor],
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          textColor: _selectedTheme[ElementStylingParameters.primaryAccentColor],
          splashColor: _selectedTheme[ElementStylingParameters.boxShadowColor],
          child: Icon(
            Icons.arrow_forward,
            color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
            size: 20,
          ),
        ),
      ),
    );
  }
}