import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/navigation/navigation.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/sites/home.dart';
import 'package:flutter_berichtsheft_app/sites/import_reports.dart';
import 'package:flutter_berichtsheft_app/sites/login.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class StartSite extends StatefulWidget {
  @override
  _StartSiteState createState() => _StartSiteState();
}

class _StartSiteState extends State<StartSite> {
  GlobalKey _showSitesComponentGKey = GlobalKey();
  Size _showSitesComponentSize = Size(0, 0);
  Offset _showSitesComponentOffset = Offset(0, 0);

  bool _showLoginComponents = LoginProvider().isLoggedIn ? false : true;
  bool _showNavigationComponents = LoginProvider().isLoggedIn ? true : false;

  _renderBox(_) {
    Timer(Duration(milliseconds: 100), () {
      if (_showSitesComponentGKey.currentContext != null) {
        final RenderBox renderBox = _showSitesComponentGKey.currentContext.findRenderObject();
        setState(() {
          _showSitesComponentSize = renderBox.size;
          _showSitesComponentOffset = renderBox.localToGlobal(Offset.zero);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  void didUpdateWidget(StartSite oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider
        .of<StylingProvider>(context, listen: false)
        .selectedTheme;
    bool _isLoggedIn = Provider
        .of<LoginProvider>(context)
        .isLoggedIn;
    Size size = MediaQuery
        .of(context)
        .size;
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
              child: _showNavigationComponents
                  ? Container(
                width: size.width - 350,
                height: size.height,
                child: Align(
                  alignment: Alignment.center,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          key: _showSitesComponentGKey,
                          margin: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
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
                                color: Colors.transparent,
                                offset: Offset(0, 0),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              //ImportReports(),
                              Home(parentSize: _showSitesComponentSize),
                            ],
                          ),
                        ),
                      ),
                    ],
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
              height: _isLoggedIn ? size.height : 320,
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
                      onEnd: () =>
                          setState(() {
                            _showLoginComponents = _isLoggedIn ? false : true;
                            _showNavigationComponents = _isLoggedIn ? true : false;
                          }),
                    ),
                    AnimatedOpacity(
                      opacity: _isLoggedIn && _showNavigationComponents ? 1 : 0,
                      duration: Duration(milliseconds: (Styling.durationAnimation / 2).round()),
                      curve: Curves.easeInOutCubic,
                      child: _showNavigationComponents ? Navigation() : Container(),
                      onEnd: () =>
                          setState(() {
                            _showLoginComponents = _isLoggedIn ? false : true;
                            _showNavigationComponents = _isLoggedIn ? true : false;
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
