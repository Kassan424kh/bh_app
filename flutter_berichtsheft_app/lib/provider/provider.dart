import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class LoginProvider with ChangeNotifier {
  Size loginAndNavigationComponentSize = Size.zero;
  Offset loginAndNavigationComponentOffset = Offset.zero;

  void loginAndNavigationComponentData(Size size, Offset offset) {
    loginAndNavigationComponentSize = size;
    loginAndNavigationComponentOffset = offset;
    notifyListeners();
  }

  bool isLoggedIn = true;

  void updateLoginStatus(bool status) {
    isLoggedIn = status;
    notifyListeners();
  }
}

class StylingProvider extends ChangeNotifier {
  var selectedTheme = Styling.darkTheme;

  void changeTheme() {
    if (selectedTheme == Styling.darkTheme)
      selectedTheme = Styling.lightTheme;
    else
      selectedTheme = Styling.darkTheme;
    notifyListeners();
  }
}
