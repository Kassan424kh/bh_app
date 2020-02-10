import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
    ElementStylingParameters.primaryColor: Color(0xffEFF8FF),
    ElementStylingParameters.primaryAccentColor: Colors.white,
    ElementStylingParameters.textColor: Color(0xff262626),
    ElementStylingParameters.headerTextColor: Color(0xff4FB2FF),
    ElementStylingParameters.inputHintTextColor: Color(0xff7FC7FF).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Color(0xff0090FF).withOpacity(.10),
    ElementStylingParameters.logoImage: "assets/images/LightLogoWithText.png",
    ElementStylingParameters.avatarImage: "assets/avatars/avatar_hell.png",
    ElementStylingParameters.logoutButtonColor: Colors.redAccent,
    ElementStylingParameters.editButtonColor: Color(0xff00D6CF),
    ElementStylingParameters.lightDarkButtonColor: Colors.orangeAccent,
    ElementStylingParameters.lightDarkButtonIcon: OMIcons.wbSunny,
    ElementStylingParameters.splashOpacity: .5,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .1,
  };
  static final darkTheme = {
    ElementStylingParameters.primaryColor: Color(0xff191B24),
    ElementStylingParameters.primaryAccentColor: Colors.black,
    ElementStylingParameters.textColor: Color(0xffBADBF4),
    ElementStylingParameters.headerTextColor: Color(0xff7FC7FF),
    ElementStylingParameters.inputHintTextColor: Color(0xffBADBF4).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Colors.black38,
    ElementStylingParameters.logoImage: "assets/images/DarkLogoWithText.png",
    ElementStylingParameters.avatarImage: "assets/avatars/avatar_dark.png",
    ElementStylingParameters.logoutButtonColor: Colors.redAccent,
    ElementStylingParameters.editButtonColor: Color(0xff97F4CF),
    ElementStylingParameters.lightDarkButtonColor: Colors.deepPurpleAccent,
    ElementStylingParameters.lightDarkButtonIcon: OMIcons.brightness2,
    ElementStylingParameters.splashOpacity: .2,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .3,
  };

  static var selectedTheme = lightTheme;

  static int durationAnimation = 500;

  static double biggestPhoneSize = 577.0;
}
