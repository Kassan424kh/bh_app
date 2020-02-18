import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/notToPushData/my_login_data.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class API {
  final BuildContext context;
  var dio = Dio();

  void clearClient () {
    dio.clear();
  }

  void _updateShowingReports(BuildContext context, {bool clearSelectedReports = true}) {
    Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
    if (clearSelectedReports){
      Provider.of<ReportsProvider>(context, listen: false).clearSelectedReports();
      Provider.of<ReportsProvider>(context, listen: false).selectAllReports([]);
    }
  }

  String _valuesToLinkQueryParameter(mapOfValuse) {
    String values = "?";
    mapOfValuse.forEach((key, value) {
      values += "$key=$value&";
    });
    return values.substring(0, values.length - 1);
  }

  API({Key key, this.context});

  final String url = "http://0.0.0.0:6666";
  Map<String, String> _headers = {"email": MyLoginData.email, "password": MyLoginData.password};

  void showDownloadProgress(received, total) {
    if (total != -1) {
      try{
        Provider.of<LoadingProgress>(context, listen: false).updateLoginStatus(received / total * 100);
      }catch(e){
        print(e);
      }
    }
  }

  void catchErrorMessage(e){
    try{
      if (e.response.statusCode == 404)
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      else
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: e.response.data["message"]);
    }catch(e){
    }
    dio.clear();
  }

  Future<bool> login(email, password) async {
    try {
      var response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(headers: {"email": email, "password": password}),
      );

      _headers["email"] = email;
      _headers["password"] = password;

      Map<String, dynamic> data = response.data;

      if (data.containsKey("loginStatus")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Welcome back ${data["userData"]["firstAndLastName"]} :)");
        Provider.of<UserData>(context, listen: false).setUserName(data["userData"]["firstAndLastName"]);
      } else if (data.containsKey("loginStatus") ? data["loginStatus"]["isLoggedIn"] : false) {
        if (data.containsKey("message")) {
          Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        } else {
          Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Login failed");
        }
      }
      dio.clear();
      return data.containsKey("loginStatus") ? data["loginStatus"]["isLoggedIn"] : false;
    } catch (e) {
      catchErrorMessage(e);
      return false;
    }
  }

  /// userData attributes are [birthday, roll, is_trainees, typeTraining, startTrainingDate, endTrainingDate]
  Future<Map<dynamic, dynamic>> addDataToNewUser(Map<dynamic, dynamic> newUserData) async {

    try {
      var response = await dio.get("${url}/update-report${_valuesToLinkQueryParameter(newUserData)}", options: Options(headers: _headers), onReceiveProgress: showDownloadProgress);
      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Report is updated ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<List<dynamic>> get reports async {

    try {
      var data = [];
      await dio
          .get(
        "${url}/get-reports",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      )
          .then((response) async {
        if (response.statusCode == 201 || response.statusCode == 200) data = await response.data;
      });
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return [];
    }
  }

  Future<List<dynamic>> get deletedReports async {

    try {
      var response = await dio.get(
        "${url}/get-deleted-reports",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );
      List<dynamic> data = response.data;
      dio.clear();
      _updateShowingReports(context);
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return [];
    }
  }

  Future<Map<dynamic, dynamic>> createNewReport(Map<dynamic, dynamic> reportData) async {

    try {
      var response = await dio.get(
        "${url}/create-new-report${_valuesToLinkQueryParameter(reportData)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );
      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "New report is created ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> updateReport(int reportID, Map<dynamic, dynamic> newReportData) async {

    try {
      newReportData["reportId"] = reportID;

      var response = await dio.get(
        "${url}/update-report${_valuesToLinkQueryParameter(newReportData)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );
      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Report is updated ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> deleteReport(int reportId, {bool deleteForever = false}) async {

    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["reportId"] = reportId;
      if (deleteForever) _valuesData["deleteForever"] = deleteForever;

      String values = "?";

      _valuesData.forEach((key, value) {
        values += "$key=$value&";
      });

      var response = await dio.get(
        "${url}/delete-report${values.substring(0, values.length - 1)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );

      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context, clearSelectedReports: false);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: deleteForever ? "Report was deleted forever ✓" : "Report was deleted ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<bool> deleteReports(List<int> reportIds, {bool permanently = false}) async {
    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["reportIds"] = reportIds;
      if (permanently) _valuesData["permanently"] = permanently;

      String values = "?";

      _valuesData.forEach((key, value) {
        values += "$key=$value&";
      });

      var response = await dio.get(
        "${url}/delete-reports${values.substring(0, values.length - 1)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );

      Map<dynamic, dynamic> data = await response.data;

      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context, clearSelectedReports: false);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/deleted-reports");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: permanently ? "Reports was deleted permanently ✓" : "Reports was deleted ✓");
        return true;
      }
      dio.clear();
    } on DioError catch (e) {
      catchErrorMessage(e);
    }
    return false;
  }

  Future revertReports(List<int> reportIds) async {

    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["reportIds"] = reportIds;

      String values = "?";

      _valuesData.forEach((key, value) {
        values += "$key=$value&";
      });

      var response = await dio.get(
        "${url}/revert-reports${values.substring(0, values.length - 1)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );

      Map<dynamic, dynamic> data = await response.data;
      if ((data != null || data.keys.length > 0) && await response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return null;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> search(String searchedText) async {

    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["searchedText"] = searchedText;

      var response = await dio.get(
        "${url}/search${_valuesToLinkQueryParameter(_valuesData)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );
      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Cannt fined any report");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> importFromRedmine(String key) async {

    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["key"] = key;

      var response = await dio.get(
        "${url}/import-from-redmine${_valuesToLinkQueryParameter(_valuesData)}",
        options: Options(headers: _headers),
        onReceiveProgress: showDownloadProgress,
      );

      Map<dynamic, dynamic> data = response.data;
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context, clearSelectedReports: false);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        dio.clear();
        return null;
      }
      dio.clear();
      return data;
    } catch (e) {
      catchErrorMessage(e);
      return null;
    }
  }

}
