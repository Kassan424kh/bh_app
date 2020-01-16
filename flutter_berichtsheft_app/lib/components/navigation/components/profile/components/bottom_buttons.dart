import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    double _widgetWidget = Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.width * 70 / 100;
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
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
              icon: Icons.edit,
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
    return SizedBox(
      width: 51,
      height: 51,
      child: RaisedButton(
        elevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        focusElevation: 0,
        animationDuration: Duration(milliseconds: Styling.durationAnimation),
        color: color.withOpacity(_selectedTheme[ElementStylingParameters.buttonsBackgroundColorOpacity]),
        splashColor: color.withOpacity(_selectedTheme[ElementStylingParameters.splashOpacity]),
        focusColor: Colors.transparent,
        textColor: Colors.transparent,
        highlightColor: Colors.transparent,
        disabledTextColor: Colors.transparent,
        disabledColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        onPressed: onClick,
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
