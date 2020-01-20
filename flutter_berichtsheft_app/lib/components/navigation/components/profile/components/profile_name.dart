import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

    return Flexible(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          "Test Test",
          style: TextStyle(
            color: _selectedTheme[ElementStylingParameters.headerTextColor],
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
