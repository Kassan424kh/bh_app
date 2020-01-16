import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/navigation/navigation.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/sites/login.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class StartSite extends StatefulWidget {
  @override
  _StartSiteState createState() => _StartSiteState();
}

class _StartSiteState extends State<StartSite> {
  GlobalKey _loginAndNavigationBoxKey = GlobalKey();
  Size _loginAndNavigationBoxSize = Size(0, 0);
  Offset _loginAndNavigationBoxOffset = Offset(0, 0);

  bool _showLoginComponents = LoginProvider().isLoggedIn ? false : true;
  bool _showNavigationComponents = LoginProvider().isLoggedIn ? true : false;

  _renderBox(_) {
    final RenderBox renderBox = _loginAndNavigationBoxKey.currentContext.findRenderObject();
    setState(() {
      _loginAndNavigationBoxSize = renderBox.size;
      _loginAndNavigationBoxOffset = renderBox.localToGlobal(Offset.zero);
    });
    Provider.of<LoginProvider>(context, listen: false).loginAndNavigationComponentData(_loginAndNavigationBoxSize, _loginAndNavigationBoxOffset);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
    super.initState();
  }

  @override
  void didUpdateWidget(StartSite oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback(_renderBox);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    bool _isLoggedIn = Provider.of<LoginProvider>(context).isLoggedIn;
    Size size = MediaQuery.of(context).size;
    return AnimatedAlign(
      duration: Duration(milliseconds: Styling.durationAnimation),
      curve: Curves.easeInOutCubic,
      alignment: _isLoggedIn ? Alignment.centerLeft : Alignment.center,
      child: AnimatedContainer(
        duration: Duration(milliseconds: Styling.durationAnimation),
        curve: Curves.easeInOutCubic,
        color: _selectedTheme[ElementStylingParameters.primaryAccentColor ],
        key: _loginAndNavigationBoxKey,
        width: _isLoggedIn ? 350 : 300,
        margin: EdgeInsets.only(
          top: 10,
          left: 10,
          bottom: 10,
        ),
        height: _isLoggedIn ? size.height : 320,
        child: Align(
          alignment: Alignment.center,
          child: Stack(
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
    );
  }
}
