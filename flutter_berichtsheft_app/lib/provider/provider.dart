import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/sites/create_new_report.dart';
import 'package:flutter_berichtsheft_app/sites/deleted_reports.dart';
import 'package:flutter_berichtsheft_app/sites/draft_reports.dart';
import 'package:flutter_berichtsheft_app/sites/home.dart';
import 'package:flutter_berichtsheft_app/sites/import_reports.dart';
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

  double showSitesCardComponentWidth = 0;
  double showSitesCardComponentHeight = 0;

  updateHeightOfShowSitesCardComponent(double newHeight){
    showSitesCardComponentHeight = newHeight;
    notifyListeners();
  }

}

class ReportsProvider extends ChangeNotifier {
  List<int> reportIds = [];

  setReportsIds(List<int> _reportIds) {
    reportIds.clear();
    reportIds.addAll(_reportIds);
  }

  List<int> listOfSelectedReports = [];
  bool areAllReportsSelected = true;

  addReportToSelectingList(int reportId) {
    if (!listOfSelectedReports.contains(reportId))
      listOfSelectedReports.add(reportId);
    else
      listOfSelectedReports.remove(reportId);

    areAllReportsSelected = !reportIds.every((reportId) => listOfSelectedReports.contains(reportId));

    notifyListeners();
  }

  selectAllReports(List<int> _reportIds) {
    bool _areAllReportsSelected = false;
    _areAllReportsSelected = _reportIds.every((reportId) => listOfSelectedReports.contains(reportId));

    listOfSelectedReports.clear();

    if (!_areAllReportsSelected)
      listOfSelectedReports.addAll(_reportIds);
    else
      listOfSelectedReports.clear();

    areAllReportsSelected = _areAllReportsSelected;

    notifyListeners();
  }

  bool showReportsAfterLoad = false;
  updateShowingReports (bool show){
    showReportsAfterLoad = show;
    notifyListeners();
  }

}

class NavigateProvider extends ChangeNotifier {
  String nowOpenedSite = "/home";
  bool updateHeightOfShowCardComponent = true;

  List<String> listOfVisitedSites = [];

  goToSite(String newSite){
    if (nowOpenedSite != newSite){
      listOfVisitedSites.add(nowOpenedSite);
      nowOpenedSite = newSite;
    }
    notifyListeners();
  }

  backToSite(){
    if (listOfVisitedSites.length >= 2 ){
      listOfVisitedSites.add(nowOpenedSite);
      nowOpenedSite = listOfVisitedSites.elementAt(listOfVisitedSites.length - 2);
      notifyListeners();
    }
  }

  Map<String, Widget> routes = {
    "/": Home(),
    "/home": Home(),
    "/import-reports": ImportReports(),
    "/create-new": CreateNewReport(),
    "/deleted-reports": DeletedReports(),
    "/draft-reports": DraftReports(),
  };
}

class MessageProvider extends ChangeNotifier {
  bool isShowMessage = false;
  int messageShowStatus = 0;
  bool messageShowingPause = false;
  bool closeMessage = false;

  showMessage(bool showMessage) {
    isShowMessage = showMessage;
    messageShowStatus = 0;
    if (showMessage == true) {
      Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        if (messageShowStatus < 100 && !messageShowingPause) {
          messageShowStatus++;
        }
        if (messageShowStatus == 100) {
          messageShowStatus = 100;
          timer.cancel();
        }
        if (closeMessage){
          messageShowStatus = 100;
          timer.cancel();
        }
      });
      closeMessage = false;
      messageShowStatus = 0;
    }
    notifyListeners();
  }
}
