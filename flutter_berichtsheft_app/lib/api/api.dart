import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class API {
  final BuildContext context;

  _updateShowingReports(BuildContext context) {
    Provider.of<ReportsProvider>(context, listen: false).updateShowingReports(false);
    Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports.clear();
    Provider.of<ReportsProvider>(context, listen: false).selectAllReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReports);
  }

  API({Key key, this.context});

  final String url = "http://0.0.0.0:5000";
  Map<String, String> _headers = {"email": "", "password": ""};

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
      return data.containsKey("loginStatus") ? data["loginStatus"]["isLoggedIn"] : false;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      return false;
    }
  }

  Future<List<dynamic>> get reports async {
    var client = http.Client();
    try {
      var response = await client.get("${url}/get-reports", headers: _headers);
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      return [];
    }
  }

  Future<List<dynamic>> get deletedReports async {
    var client = http.Client();
    try {
      var response = await client.get("${url}/get-deleted-reports", headers: _headers);
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      return [];
    }
  }

  Future<Map<dynamic, dynamic>> createNewReport(Map<dynamic, dynamic> reportData) async {
    var client = http.Client();
    try {
      String values = "?";

      reportData.forEach((key, value) {
        values += "$key=$value&";
      });

      print("${url}/create-new-report${values.substring(0, values.length - 1)}");
      var response = await client.get(
        "${url}/create-new-report${values.substring(0, values.length - 1)}",
        headers: _headers,
      );
      Map<dynamic, dynamic> data = jsonDecode(response.body);
      if ((data != null || data.keys.length > 0) && response.statusCode == 201) {
        _updateShowingReports(context);
        Provider.of<NavigateProvider>(context, listen: false).goToSite("/home");
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "New report is created ✓");
      }else if (data.containsKey("message")){
        Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: data["message"]);
        return null;
      }
      return data;
    } catch (e) {
      print(e);
      Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Failed Server connection!!!");
      return null;
    }
  }
}
