import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class AppLogo extends StatelessWidget {
  final EdgeInsets padding;

  AppLogo({
    Key key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) => AnimatedContainer(
          duration: Duration(milliseconds: Styling.durationAnimation),
          padding: padding,
          constraints: BoxConstraints.expand(),
          child: Image.asset(
            _selectedTheme[ElementStylingParameters.logoImage],
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
