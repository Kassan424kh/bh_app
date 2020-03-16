import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/message.dart';
import 'package:flutter_berichtsheft_app/components/mobil_header.dart';
import 'package:flutter_berichtsheft_app/components/navigation/navigation.dart';
import 'package:flutter_berichtsheft_app/components/ui_circle_button.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/routes/routes.dart';
import 'package:flutter_berichtsheft_app/sites/login.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class StartSite extends StatefulWidget {
  @override
  _StartSiteState createState() => _StartSiteState();
}

class _StartSiteState extends State<StartSite> {
  bool _showLoginComponents = LoginProvider().isLoggedIn ? false : true;
  bool _showNavigationComponents = LoginProvider().isLoggedIn ? true : false;

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    bool _isLoggedIn = Provider.of<LoginProvider>(context).isLoggedIn;
    Size size = MediaQuery.of(context).size;
    //double _showCardComponentWidth = Provider.of<StylingProvider>(context).showSitesCardComponentWidth;
    double _showCardComponentHeight = Provider.of<StylingProvider>(context).showSitesCardComponentHeight;
    //double _progress = Provider.of<LoadingProgress>(context).loadingProgress;
    bool _openNavigation = Provider.of<NavigationProvider>(context).isOpen;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Data Sites Card
          AnimatedPositioned(
            duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
            curve: Curves.easeInOutCubic,
            left: size.width <= Styling.tabletSize ? 0 : _isLoggedIn && _showNavigationComponents ? 350 : 350 * 70 / 100,
            child: AnimatedOpacity(
              opacity: _isLoggedIn && _showNavigationComponents ? 1 : 0,
              duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
              curve: Curves.easeInOutCubic,
              onEnd: () {
                Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(_isLoggedIn ? true : false);
              },
              child: _showNavigationComponents
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        size.width <= Styling.tabletSize && _isLoggedIn
                            ? Container(
                                height: 90,
                                width: size.width,
                              )
                            : Container(),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: size.width <= Styling.tabletSize ? size.width : size.width - 350,
                              height: size.width <= Styling.tabletSize ? size.height - 100 : size.height,
                              child: Align(
                                alignment: Alignment.center,
                                child: LayoutBuilder(
                                  builder: (BuildContext context, BoxConstraints constraints) {
                                    double width = constraints.maxWidth - (constraints.maxWidth * 15 / 100);
                                    Timer(Duration(milliseconds: 10), () {
                                      if (_isLoggedIn && _showNavigationComponents && Provider.of<StylingProvider>(context, listen: false).showSitesCardComponentWidth != width)
                                        Provider.of<StylingProvider>(context, listen: false).updateWidthOfShowSitesCardComponent(width);
                                    });
                                    return AnimatedContainer(
                                      duration: Duration(milliseconds: (Styling.durationAnimation / 4).round()),
                                      curve: Curves.easeOutCubic,
                                      width: constraints.maxWidth - (constraints.maxWidth * (size.width <= Styling.tabletSize ? 10 : 15) / 100),
                                      height: _showCardComponentHeight,
                                      onEnd: () {
                                        if (["/", "/home", "/deleted-reports", "/draft-reports", "/search"].contains(Provider.of<NavigateProvider>(context, listen: false).nowOpenedSite))
                                          Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(true);
                                      },
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                                        boxShadow: [
                                          _isLoggedIn && _showNavigationComponents
                                              ? BoxShadow(
                                                  color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                                                  offset: Offset(15, 20),
                                                  blurRadius: 50,
                                                )
                                              : BoxShadow(
                                                  color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                                                  offset: Offset(0, 0),
                                                  blurRadius: 0,
                                                ),
                                        ],
                                      ),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        fit: StackFit.passthrough,
                                        children: <Widget>[
                                          Routes.routes[Provider.of<NavigateProvider>(context, listen: false).nowOpenedSite],
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
          MobileHeader(
            isNavigationOpened: _openNavigation,
          ),
          // Login and Left Navigation
          AnimatedAlign(
            duration: Duration(milliseconds: Styling.durationAnimation),
            curve: Curves.easeInOutCubic,
            alignment:
                _isLoggedIn ? Alignment.centerLeft.add(Alignment(size.width <= Styling.tabletSize && _isLoggedIn && _showNavigationComponents && !_openNavigation ? -5 : 0, 0)) : Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: Styling.durationAnimation),
              curve: Curves.easeInOutCubic,
              width: _isLoggedIn ? 350 : 300,
              height: _isLoggedIn ? size.height : 375,
              decoration: BoxDecoration(
                color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
                boxShadow: [
                  size.width <= Styling.tabletSize && _isLoggedIn && _showNavigationComponents && _openNavigation
                      ? BoxShadow(
                          color: _selectedTheme[ElementStylingParameters.boxShadowColor],
                          offset: Offset(15, 20),
                          blurRadius: 50,
                        )
                      : BoxShadow(
                          color: Colors.transparent,
                          offset: Offset(0, 0),
                          blurRadius: 0,
                        ),
                ],
              ),
              margin: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: !_isLoggedIn && _showLoginComponents ? 1 : 0,
                      duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
                      curve: Curves.easeInOutCubic,
                      child: _showLoginComponents ? Login(title: "Login") : Container(),
                      onEnd: () => setState(() {
                        _showLoginComponents = _isLoggedIn ? false : true;
                        _showNavigationComponents = _isLoggedIn ? true : false;
                      }),
                    ),
                    AnimatedOpacity(
                      opacity: _isLoggedIn && _showNavigationComponents ? 1 : 0,
                      duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
                      curve: Curves.easeInOutCubic,
                      child: _showNavigationComponents ? Navigation() : Container(),
                      onEnd: () => setState(() {
                        _showLoginComponents = _isLoggedIn ? false : true;
                        _showNavigationComponents = _isLoggedIn ? true : false;
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Message()
        ],
      ),
    );
  }
}
