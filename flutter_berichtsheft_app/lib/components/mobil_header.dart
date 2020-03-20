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
                  decoration: BoxDecoration(
                    color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                    boxShadow: [
                      BoxShadow(
                        color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                        offset: Offset(15, 20),
                        blurRadius: 50,
                      )
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      width: size.width - (size.width * (size.width <= Styling.tabletSize ? 10 : 15) / 100),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          UICircleButton(
                            icon: Container(
                              height: 25,
                              width: 35,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 6,
                                    color: _selectedTheme[ElementStylingParameters.primaryColor],
                                    child: Center(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        height: 0.6,
                                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 6,
                                    margin: EdgeInsets.only(left: 5),
                                    color: _selectedTheme[ElementStylingParameters.primaryColor],
                                    child: Center(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        height: 0.6,
                                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 6,
                                    margin: EdgeInsets.only(left: 5),
                                    color: _selectedTheme[ElementStylingParameters.primaryColor],
                                    child: Center(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        height: 0.6,
                                        color: _selectedTheme[ElementStylingParameters.headerTextColor],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onClick: () {
                              Provider.of<NavigationProvider>(context, listen: false).openNavigation(true);
                            },
                            noneBackgroundColor: true,
                            toolTipMessage: "Open menu",
                            buttonSize: 70,
                            color: _selectedTheme[ElementStylingParameters.headerTextColor],
                          ),
                          Hero(
                            tag: "navigationLogo",
                            child: AppLogo(
                              fit: BoxFit.fitHeight,
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
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
