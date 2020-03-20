import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/bottom_buttons.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/profile_image.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/components/profile_name.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class ProfileInfos extends StatefulWidget {
  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Flexible(
      fit: FlexFit.loose,
      flex: 7,
      child: Container(
        margin: EdgeInsets.only(top: 350 * 6 / 100),
        width: 350,
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: <Widget>[
            size.width > Styling.tabletSize
                ? Hero(
                    tag: "navigationLogo",
                    child: AppLogo(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                    ),
                  )
                : SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ProfileImage(),
                size.width < Styling.tabletSize
                    ? ProfileName(fontSize: 20) : Container(),
              ],
            ),
            size.width > Styling.tabletSize
                ? ProfileName()
                : SizedBox(height: 20),
            BottomButtons(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
