import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class MobileHeader extends StatelessWidget {
  final bool isNavigationOpened;

  MobileHeader({Key key, this.isNavigationOpened}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    bool _isLoggedIn = Provider.of<LoginProvider>(context).isLoggedIn;
    Size size = MediaQuery.of(context).size;
    return size.width <= Styling.tabletSize && _isLoggedIn
        ? Positioned.fill(
            top: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 60,
                      width: size.width - (size.width * (size.width <= Styling.tabletSize ? 10 : 15) / 100),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          !isNavigationOpened
                              ? Hero(
                                  tag: "openNaviButton",
                                  child: UICircleButton(
                                    icon: Icons.short_text,
                                    onClick: () {
                                      Provider.of<NavigationProvider>(context, listen: false).openNavigation(true);
                                    },
                                    toolTipMessage: "Open menu",
                                    color: _selectedTheme[ElementStylingParameters.headerTextColor],
                                  ),
                                )
                              : Container(),
                          AppLogo(
                            fit: BoxFit.fitHeight,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
