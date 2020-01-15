import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/app_logo.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/navigation_buttons.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/profileInfos.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/search_input_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Flex(
          direction: Axis.vertical,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            SizedBox(
              height: Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.height * 12 / 100,
              width: Provider.of<LoginProvider>(context).loginAndNavigationComponentSize.width,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  AppLogo(padding: EdgeInsets.all(30)),
                ],
              ),
            ),
            ProfileInfos(),
            SearchInputField(),
            NavigationButtons(),
          ],
        ),
      ],
    );
  }
}
