import 'package:flutter/material.dart';

enum ElementStylingParameters {
  primaryColor,
  primaryAccentColor,
  textColor,
  headerTextColor,
  inputHintTextColor,
  boxShadowColor,
  logoImage,
  avatarImage,
  logoutButtonColor,
  editButtonColor,
  lightDarkButtonColor,
  lightDarkButtonIcon,
  splashOpacity,
  buttonsBackgroundColorOpacity,
}

class Styling {
  static final lightTheme = {
    ElementStylingParameters.primaryColor: Color(0xffECFFFE),
    ElementStylingParameters.primaryAccentColor: Colors.white,
    ElementStylingParameters.textColor: Color(0xff262626),
    ElementStylingParameters.headerTextColor: Color(0xff25CEBB),
    ElementStylingParameters.inputHintTextColor: Color(0xff48F4DE).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Color(0xff6DDFFF),
    ElementStylingParameters.logoImage: "assets/images/bh_logo_hell.png",
    ElementStylingParameters.avatarImage: "assets/avatars/avatar_hell.png",
    ElementStylingParameters.logoutButtonColor: Colors.red,
    ElementStylingParameters.editButtonColor: Color(0xff00C0A7),
    ElementStylingParameters.lightDarkButtonColor: Colors.orangeAccent,
    ElementStylingParameters.lightDarkButtonIcon: Icons.wb_sunny,
    ElementStylingParameters.splashOpacity: .5,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .1,
  };
  static final darkTheme = {
    ElementStylingParameters.primaryColor: Color(0xff262626),
    ElementStylingParameters.primaryAccentColor: Colors.black,
    ElementStylingParameters.textColor: Color(0xffA5FFE2),
    ElementStylingParameters.headerTextColor: Color(0xff00C0A7),
    ElementStylingParameters.inputHintTextColor: Color(0xff00C0A7).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Color(0xff006E66),
    ElementStylingParameters.logoImage: "assets/images/bh_logo_dark.png",
    ElementStylingParameters.avatarImage: "assets/avatars/avatar_dark.png",
    ElementStylingParameters.logoutButtonColor: Colors.redAccent,
    ElementStylingParameters.editButtonColor: Color(0xff48F4DE),
    ElementStylingParameters.lightDarkButtonColor: Colors.deepPurpleAccent,
    ElementStylingParameters.lightDarkButtonIcon: Icons.brightness_2,
    ElementStylingParameters.splashOpacity: .2,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .3,
  };

  static var selectedTheme = lightTheme;

  static double biggestPhoneSize = 577.0;
}
