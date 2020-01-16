import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/sites/start_site.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context, listen: false).selectedTheme;
    bool _isLoggedIn = Provider.of<LoginProvider>(context).isLoggedIn;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: Styling.durationAnimation),
                color: _selectedTheme[ElementStylingParameters.primaryColor],
                child: StartSite(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
