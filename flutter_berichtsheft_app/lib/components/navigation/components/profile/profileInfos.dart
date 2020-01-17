import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/bottom_buttons.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/profile_image.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/profile_name.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';

class ProfileInfos extends StatefulWidget {
  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  @override
  Widget build(BuildContext context) {
    double _widgetWidth = Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.width;
    return Flexible(
      fit: FlexFit.loose,
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(top: _widgetWidth * 6 / 100),
        width: _widgetWidth,
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: <Widget>[
            AppLogo(
              padding: EdgeInsets.all(20),
            ),
            ProfileImage(),
            ProfileName(),
            BottomButtons(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
