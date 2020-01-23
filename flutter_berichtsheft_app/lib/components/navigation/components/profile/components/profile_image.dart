import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular((350 * 35 / 100) * 2)),
      child: Container(
        height: (350 * 35 / 100),
        width: (350 * 35 / 100),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                _selectedTheme[ElementStylingParameters.avatarImage],
              ),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
