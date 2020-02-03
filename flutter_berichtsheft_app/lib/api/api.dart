import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class API {

  final BuildContext context;

  API({Key key, this.context});
  
  static final String url = "http://0.0.0.0:5000/";

  static Future<bool> login(email, password) async {
    var response = await http.get(url, headers: {"email": email, "password": password});
    Map<String, dynamic> userData = jsonDecode(response.body);
    print(userData.containsKey("loginStatus")? userData["loginStatus"]["isLoggedIn"] : false);
    return userData.containsKey("loginStatus")? userData["loginStatus"]["isLoggedIn"] : false;
  }
}
