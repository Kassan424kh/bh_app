import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static final String url = "http://0.0.0.0:5000/";

  static Future<bool> login(email, password) async {
    var response = await http.get(url, headers: {"email": email, "password": password});
    Map<String, dynamic> userData = jsonDecode(response.body);
    print(email + " ***** " + password);
    print(userData.containsKey("loginStatus")? userData["loginStatus"]["isLoggedIn"] : false);
    return userData.containsKey("loginStatus")? userData["loginStatus"]["isLoggedIn"] : false;
  }
}
