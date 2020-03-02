import 'package:crypted_preferences/crypted_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/sites/start_site.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  API _api;

  @override
  void initState() {
    super.initState();
    _api = API(context: context);
    _api.userData;
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
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
