import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    double _widgetWidget = Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.width * 70 / 100;
    return Container(
      width: _widgetWidget,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Button(
            color: _selectedTheme[ElementStylingParameters.logoutButtonColor],
            icon: Icons.power_settings_new,
            onClick: () {
              Provider.of<LoginProvider>(context, listen: false).updateLoginStatus(
                Provider.of<LoginProvider>(context, listen: false).isLoggedIn ? false : true,
              );
            },
          ),
          Button(
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: OMIcons.print,
            onClick: () {},
          ),
          Button(
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: Icons.save_alt,
            onClick: () {},
          ),
          Button(
            color: _selectedTheme[ElementStylingParameters.lightDarkButtonColor],
            icon: _selectedTheme[ElementStylingParameters.lightDarkButtonIcon],
            onClick: () {
              Provider.of<StylingProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Color color;
  final icon;
  final onClick;

  Button({
    Key key,
    this.color,
    this.icon,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        color: color.withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
        focusColor: Colors.transparent,
        splashColor: color.withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
        highlightColor: color.withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
        disabledColor: Colors.transparent,
        onPressed: onClick,
        icon: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
