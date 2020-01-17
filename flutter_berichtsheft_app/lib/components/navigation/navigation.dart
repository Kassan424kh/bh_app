import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/navigation_buttons.dart';
import 'package:flutter_berichtsheft_app/components/navigation/components/profile/profileInfos.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        ProfileInfos(),
        NavigationButtons(),
      ],
    );
  }
}
