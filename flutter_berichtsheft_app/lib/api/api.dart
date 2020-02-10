import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_berichtsheft_app/notToPushData/my_login_data.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class API {
  final BuildContext context;

  void _updateShowingReports(BuildContext context) {
    Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
    Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports.clear();
    Provider.of<ReportsProvider>(context, listen: false).selectAllReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports);
  }

  String _valuesToLinkQueryParameter(mapOfValuse) {
    String values = "?";
    mapOfValuse.forEach((key, value) {
      values += "$key=$value&";
    });
    return values.substring(0, values.length - 1);
  }

  API({Key key, this.context});

  final String url = "http://0.0.0.0:6666"; // be sure the url not with "/" ended
  Map<String, String> _headers = {"email": MyLoginData.email, "password": MyLoginData.password};

  Future<bool> login(email, password) async {
    var client = http.Client();
    try {
      var response = await client.get(url, headers: {"email": email, "password": password});
      _headers["email"] = email;
      _headers["password"] = password;
      Map<String, dynamic> data = jsonDecode(response.body);

      if (!data.containsKey("loginStatus") && (response.statusCode != 200 || response.statusCode != 201)) {
        if (data.containsKey("message")) {
          Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        } else {
          Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Login failed");
        }
      } else if (data.containsKey("loginStatus") ? data["loginStatus"]["isLoggedIn"] : false) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Welcome back ${data["userData"]["firstAndLastName"]} :)");
      }
      client.close();
      return data.containsKey("loginStatus") ? data["loginStatus"]["isLoggedIn"] : false;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return false;
    }
  }

  /// userData attributes are [birthday, roll, is_trainees, typeTraining, startTrainingDate, endTrainingDate]
  Future<Map<dynamic, dynamic>> addDataToNewUser(Map<dynamic, dynamic> newUserData) async {
    var client = http.Client();
    try {
      var response = await client.get(
        "${url}/update-report${_valuesToLinkQueryParameter(newUserData)}",
        headers: _headers,
      );
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Report is updated ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        client.close();
        return null;
      }
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return null;
    }
  }

  Future<List<dynamic>> get reports async {
    var client = http.Client();
    try {
      var data = [];
      await client.get("${url}/get-reports", headers: _headers).then((response) async {
        if (response.statusCode == 201 || response.statusCode == 200 ) data = await jsonDecode(response.body);
      });
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return [];
    }
  }

  Future<List<dynamic>> get deletedReports async {
    var client = http.Client();
    try {
      var response = await client.get("${url}/get-deleted-reports", headers: _headers);
      List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return [];
    }
  }

  Future<Map<dynamic, dynamic>> createNewReport(Map<dynamic, dynamic> reportData) async {
    var client = http.Client();
    try {
      var response = await client.get(
        "${url}/create-new-report${_valuesToLinkQueryParameter(reportData)}",
        headers: _headers,
      );
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "New report is created ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        client.close();
        return null;
      }
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> updateReport(int reportID, Map<dynamic, dynamic> newReportData) async {
    var client = http.Client();
    try {
      newReportData["reportId"] = reportID;

      var response = await client.get(
        "${url}/update-report${_valuesToLinkQueryParameter(newReportData)}",
        headers: _headers,
      );
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Report is updated ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        client.close();
        return null;
      }
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> deleteReport(int reportId, {bool deleteForever = false}) async {
    var client = http.Client();
    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["reportId"] = reportId;
      if (deleteForever) _valuesData["deleteForever"] = deleteForever;

      String values = "?";

      _valuesData.forEach((key, value) {
        values += "$key=$value&";
      });

      var response = await client.get(
        "${url}/delete-report${values.substring(0, values.length - 1)}",
        headers: _headers,
      );

      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: deleteForever ? "Report was deleted forever ✓" : "Report was deleted ✓");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        client.close();
        return null;
      }
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> search(String searchedText) async {
    var client = http.Client();
    try {
      Map<String, dynamic> _valuesData = {};
      _valuesData["searchedText"] = searchedText;

      var response = await client.get(
        "${url}/search${_valuesToLinkQueryParameter(_valuesData)}",
        headers: _headers,
      );
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Cannt fined any report");
      } else if (data.containsKey("message")) {
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        client.close();
        return null;
      }
      client.close();
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      client.close();
      return null;
    }
  }
}
