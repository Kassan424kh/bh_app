import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';

class LoadingProgress with ChangeNotifier{
  double loadingProgress = 0;

  void updateLoginStatus(double progress) {
    loadingProgress = progress;
    notifyListeners();
  }
}

class LoginProvider with ChangeNotifier {
  bool isLoggedIn = false;

  void updateLoginStatus(bool status) {
    isLoggedIn = status;
    notifyListeners();
  }
}
class UserData with ChangeNotifier {
  String userName = "";

  void setUserName(String uName) {
    userName = uName;
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

  updateHeightOfShowSitesCardComponent(double newHeight) {
    showSitesCardComponentHeight = newHeight;
    notifyListeners();
  }
  updateWidthOfShowSitesCardComponent(double newWidth) {
    showSitesCardComponentWidth = newWidth;
    notifyListeners();
  }
}

class ReportsProvider extends ChangeNotifier {
  List<int> reportIds = [];
  List listOfFoundReports= [];

  setReportsIds(List<int> _reportIds) {
    reportIds.clear();
    reportIds.addAll(_reportIds);
  }

  setListOfFoundReports (List foundReports){
    listOfFoundReports = foundReports;
    notifyListeners();
  }
  clearListOfFoundReports (){
    listOfFoundReports = [];
    notifyListeners();
  }

  List<int> listOfSelectedReportIds = [];
  bool areAllReportsSelected = true;

  addReportToSelectingList(int reportId) {
    if (!listOfSelectedReportIds.contains(reportId))
      listOfSelectedReportIds.add(reportId);
    else
      listOfSelectedReportIds.remove(reportId);

    areAllReportsSelected = !reportIds.every((reportId) => listOfSelectedReportIds.contains(reportId));

    notifyListeners();
  }

  selectAllReports(List<int> _reportIds) {
    bool _areAllReportsSelected = false;
    _areAllReportsSelected = _reportIds.every((reportId) => listOfSelectedReportIds.contains(reportId));

    listOfSelectedReportIds.clear();

    if (!_areAllReportsSelected)
      listOfSelectedReportIds.addAll(_reportIds);
    else
      listOfSelectedReportIds.clear();

    areAllReportsSelected = _areAllReportsSelected;

    notifyListeners();
  }

  clearSelectedReports(){
    listOfSelectedReportIds = [];
    notifyListeners();
  }

  bool showReportsAfterLoad = true;

  updateShowingReports(bool show) {
    showReportsAfterLoad = show;
    notifyListeners();
  }
}

class NavigateProvider extends ChangeNotifier {
  String nowOpenedSite = "/home";
  bool isNavigatedOrOnStart = false;

  List<String> listOfVisitedSites = [];

  goToSite(String newSite) {
    if (nowOpenedSite != newSite) {
      listOfVisitedSites.add(nowOpenedSite);
      nowOpenedSite = newSite;
    }
    notifyListeners();
  }

  backToSite() {
    if (listOfVisitedSites.length >= 2) {
      listOfVisitedSites.add(nowOpenedSite);
      nowOpenedSite = listOfVisitedSites.elementAt(listOfVisitedSites.length - 2);
    }
    notifyListeners();
  }
}

class MessageProvider extends ChangeNotifier {
  bool isShowMessage = false;
  int messageShowStatus = 0;
  bool messageShowingPause = false;
  bool closeMessage = false;
  String typeOfMessage = "good";
  dynamic messageOkButton;

  String messageTexts = "Message text faild!!!";

  showMessage(bool showMessage, {String messageText = "", type = "good", dynamic okButton}) {
    isShowMessage = showMessage;
    messageTexts = messageText;
    messageShowStatus = 0;
    typeOfMessage = type;
    Timer(Duration(milliseconds: 10), (){
      this.messageOkButton = okButton;
      notifyListeners();
    });

    Timer _timer;
    if (showMessage == true) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
        if (messageShowStatus < 100 && !messageShowingPause) {
          messageShowStatus++;
        }
        if (messageShowStatus == 100) {
          messageShowStatus = 100;
          messageText = "Message text faild!!!";
          timer.cancel();
        }
        if (closeMessage) {
          messageShowStatus = 100;
          timer.cancel();
        }
        notifyListeners();
      });
      closeMessage = false;
      messageShowStatus = 0;
      if (!_timer.isActive)messageTexts = "Message text faild!!!";
      typeOfMessage = "good";
      messageOkButton = null;
      notifyListeners();
    }
    notifyListeners();
  }
}


