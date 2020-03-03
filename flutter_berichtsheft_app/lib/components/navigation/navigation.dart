import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/navigation_buttons.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/profileInfos.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Stack(
      children: <Widget>[
        Provider.of<NavigationProvider>(context).isOpen ?
        Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topRight,
            child: Hero(
              tag: "openNaviButton",
              child: UICircleButton(
                icon: Icons.close,
                onClick: () {
                  Provider.of<NavigationProvider>(context, listen: false).openNavigation(false);
                },
                buttonSize: 40,
                toolTipMessage: "Close menu",
                color: _selectedTheme[ElementStylingParameters.logoutButtonColor],
              ),
            ),
          ),
        ): Container(),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ProfileInfos(),
            Flexible(fit: FlexFit.loose,flex: 5,child: NavigationButtons()),
          ],
        ),
      ],
    );
  }
}
