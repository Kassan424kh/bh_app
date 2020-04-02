import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

enum ElementStylingParameters {
  primaryColor,
  primaryAccentColor,
  textColor,
  headerTextColor,
  inputHintTextColor,
  boxShadowColor,
  logoutButtonColor,
  editButtonColor,
  lightDarkButtonColor,
  lightDarkButtonIcon,
  splashOpacity,
  buttonsBackgroundColorOpacity,
  backgroundGradientColors,
}

enum SitesIcons {
  logoImage,
  avatarImage,
  nullHomeReports,
  nullFoundReports,
  nullDeletedReports,
}

class Styling {
  static final lightTheme = {
    ElementStylingParameters.primaryColor: Color(0xffEFF8FF),
    ElementStylingParameters.primaryAccentColor: Colors.white,
    ElementStylingParameters.textColor: Color(0xff262626),
    ElementStylingParameters.headerTextColor: Color(0xff4FB2FF),
    ElementStylingParameters.inputHintTextColor: Color(0xff7FC7FF).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Color(0xff0090FF).withOpacity(.10),
    SitesIcons.logoImage: "assets/images/LightLogoWithText.png",
    SitesIcons.avatarImage: "assets/images/profile_light.png",
    SitesIcons.nullHomeReports : "assets/images/null_reports_light.png",
    SitesIcons.nullFoundReports : "assets/images/null_search_light.png",
    SitesIcons.nullDeletedReports : "assets/images/null_delet_light.png",
    ElementStylingParameters.logoutButtonColor: Colors.redAccent,
    ElementStylingParameters.editButtonColor: Color(0xff00D6CF),
    ElementStylingParameters.lightDarkButtonColor: Colors.orangeAccent,
    ElementStylingParameters.lightDarkButtonIcon: OMIcons.wbSunny,
    ElementStylingParameters.splashOpacity: .5,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .1,
    ElementStylingParameters.backgroundGradientColors: [Color(0xff97F4CF), Color(0xff0090FF)]
  };
  static final darkTheme = {
    ElementStylingParameters.primaryColor: Color(0xff191B24),
    ElementStylingParameters.primaryAccentColor: Colors.black,
    ElementStylingParameters.textColor: Color(0xffBADBF4),
    ElementStylingParameters.headerTextColor: Color(0xff7FC7FF),
    ElementStylingParameters.inputHintTextColor: Color(0xffBADBF4).withOpacity(.63),
    ElementStylingParameters.boxShadowColor: Colors.black38,
    SitesIcons.logoImage: "assets/images/DarkLogoWithText.png",
    SitesIcons.avatarImage: "assets/images/profile_dark.png",
    SitesIcons.nullHomeReports : "assets/images/null_reports_dark.png",
    SitesIcons.nullFoundReports : "assets/images/null_search_dark.png",
    SitesIcons.nullDeletedReports : "assets/images/null_delet_dark.png",
    ElementStylingParameters.logoutButtonColor: Colors.redAccent,
    ElementStylingParameters.editButtonColor: Color(0xff97F4CF),
    ElementStylingParameters.lightDarkButtonColor: Colors.deepPurpleAccent,
    ElementStylingParameters.lightDarkButtonIcon: OMIcons.brightness2,
    ElementStylingParameters.splashOpacity: .2,
    ElementStylingParameters.buttonsBackgroundColorOpacity: .3,
    ElementStylingParameters.backgroundGradientColors: [Colors.deepPurpleAccent, Color(0xff0090FF)],
  };

  static var selectedTheme = lightTheme;

  static int durationAnimation = 350;

  static double tabletSize = 1400;
  static double phoneSize = 1060;
}
