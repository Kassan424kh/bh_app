import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class UILoginButton extends StatelessWidget{
  final onPressed;

  UILoginButton({Key key , this.onPressed}): super(key:key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

    return Container(
      width: 60,
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
            angle: 0,
            child: Text("GO", style: TextStyle(color: _selectedTheme[ElementStylingParameters.primaryAccentColor])),
          ),
        ),
      ),
    );
  }
}