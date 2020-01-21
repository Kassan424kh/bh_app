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

  void setShowSitesCardComponentData(Size size, Offset offset) {
    showSitesCardComponentSize = size;
    showSitesCardComponentOffset = offset;

    notifyListeners();
  }
}

class ReportsProvider extends ChangeNotifier {
  List<int> reportIds = [];
  setReportsIds(List<int> _reportIds){
    reportIds.clear();
    reportIds.addAll(_reportIds);
  }


  List<int> listOfSelectedReports = [];
  bool areAllReportsSelected = true;

  addReportToSelectingList(int reportId) {
    print(reportId);
    if (!listOfSelectedReports.contains(reportId)) listOfSelectedReports.add(reportId);
    else listOfSelectedReports.remove(reportId);

    areAllReportsSelected = !reportIds.every((reportId) => listOfSelectedReports.contains(reportId));

    notifyListeners();
  }

  selectAllReports(List<int> _reportIds) {
    bool _areAllReportsSelected = false;

    _areAllReportsSelected = _reportIds.every((reportId) => listOfSelectedReports.contains(reportId));

    if (!_areAllReportsSelected) listOfSelectedReports.addAll(_reportIds);
    else listOfSelectedReports.clear();

    areAllReportsSelected = _areAllReportsSelected;

    notifyListeners();
  }
}
