import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class LoginProvider with ChangeNotifier {
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

  Size showSitesCardComponentSize = Size(0, 0);
  Offset showSitesCardComponentOffset = Offset(0, 0);

  void setShowSitesCardComponentData(Size size, Offset offset){
    showSitesCardComponentSize = size;
    showSitesCardComponentOffset = offset;

    notifyListeners();
  }

}
