import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _widgetWidget = Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.width * 35 / 100;
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(_widgetWidget * 2)),
      child: Container(
        height: _widgetWidget,
        width: _widgetWidget,
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
