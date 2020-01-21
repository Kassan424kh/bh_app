import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class BottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Container(
      width: 350 * 70 / 100,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Button(
            toolTipMessage: "Logout",
            color: _selectedTheme[ElementStylingParameters.logoutButtonColor],
            icon: Icons.power_settings_new,
            onClick: () {
              Provider.of<LoginProvider>(context, listen: false).updateLoginStatus(
                Provider.of<LoginProvider>(context, listen: false).isLoggedIn ? false : true,
              );
            },
          ),
          Button(
            toolTipMessage: "Import Reports",
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: OMIcons.cloudUpload,
            onClick: () {},
          ),
          Button(
            toolTipMessage: "Export/Save Reports as JSON",
            color: _selectedTheme[ElementStylingParameters.editButtonColor],
            icon: Icons.save_alt,
            onClick: () {},
          ),
          Button(
            toolTipMessage: Provider.of<StylingProvider>(context).selectedTheme == Styling.darkTheme ? "Darkmode" : "Nightmode",
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
  final String toolTipMessage;

  Button({
    Key key,
    this.color,
    this.icon,
    this.onClick,
    this.toolTipMessage = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Tooltip(
      message: toolTipMessage,
      child: Container(
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
      ),
    );
  }
}
