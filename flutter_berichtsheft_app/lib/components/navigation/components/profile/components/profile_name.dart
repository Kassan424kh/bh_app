import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ProfileName extends StatelessWidget {
  final double fontSize;

  ProfileName({Key key, this.fontSize = 30}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

    return Flexible(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          Provider.of<UserData>(context).userName,
          style: TextStyle(
            color: _selectedTheme[ElementStylingParameters.headerTextColor],
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
