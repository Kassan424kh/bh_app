import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class UICircleButton extends StatelessWidget{
  final onPressed;

  UICircleButton({Key key , this.onPressed}): super(key:key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

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
          child: Transform.rotate(
            angle: radians(360 / 12) * 30,
            child: Icon(
              Icons.trending_flat,
              color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}