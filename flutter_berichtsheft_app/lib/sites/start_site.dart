import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/message.dart';
import 'package:flutter_berichtsheft_app/components/navigation/navigation.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/sites/import_reports.dart';
import 'package:flutter_berichtsheft_app/sites/login.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class StartSite extends StatefulWidget {
  @override
  _StartSiteState createState() => _StartSiteState();
}

class _StartSiteState extends State<StartSite>  {
  bool _showLoginComponents = LoginProvider().isLoggedIn ? false : true;
  bool _showNavigationComponents = LoginProvider().isLoggedIn ? true : false;
  bool _loadListOfReports = LoginProvider().isLoggedIn ? true : false;

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    bool _isLoggedIn = Provider.of<LoginProvider>(context).isLoggedIn;
    Size size = MediaQuery.of(context).size;
    double _showCardComponentWidth = Provider.of<StylingProvider>(context).showSitesCardComponentWidth;
    double _showCardComponentHeight = Provider.of<StylingProvider>(context).showSitesCardComponentHeight;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
            curve: Curves.easeInOutCubic,
            left: _isLoggedIn && _showNavigationComponents ? 350 : 350 * 70 / 100,
            child: AnimatedOpacity(
              opacity: _isLoggedIn && _showNavigationComponents ? 1 : 0,
              duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
              curve: Curves.easeInOutCubic,
              onEnd: () {
                Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(_isLoggedIn ? true : false);
              },
              child: _showNavigationComponents
                  ? Container(
                      width: size.width - 350,
                      height: size.height,
                      child: Align(
                        alignment: Alignment.center,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            Timer(Duration(milliseconds: 10), () {
                              if (_isLoggedIn && _showNavigationComponents)
                                Provider.of<StylingProvider>(context, listen: false).showSitesCardComponentWidth = constraints.maxWidth - (constraints.maxWidth * 15 / 100);
                            });
                            return AnimatedContainer(
                              duration: Duration(milliseconds: (Styling.durationAnimation / 4).round()),
                              curve: Curves.easeOutCubic,
                              width: constraints.maxWidth - (constraints.maxWidth * 15 / 100),
                              height: _showCardComponentHeight,
                              onEnd: () {
                                if (["/", "/home", "/deleted-reports", "/draft-reports"].contains(Provider.of<NavigateProvider>(context, listen: false).nowOpenedSite))
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
                              child: ClipRect(
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Provider.of<NavigateProvider>(context).routes[Provider.of<NavigateProvider>(context).nowOpenedSite],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
          AnimatedAlign(
            duration: Duration(milliseconds: Styling.durationAnimation),
            curve: Curves.easeInOutCubic,
            alignment: _isLoggedIn ? Alignment.centerLeft : Alignment.center,
            child: AnimatedContainer(
              duration: Duration(milliseconds: Styling.durationAnimation),
              curve: Curves.easeInOutCubic,
              color: _selectedTheme[ElementStylingParameters.primaryAccentColor],
              width: _isLoggedIn ? 350 : 300,
              height: _isLoggedIn ? size.height : 375,
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
