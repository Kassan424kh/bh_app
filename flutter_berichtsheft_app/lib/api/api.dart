import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class API {

  final BuildContext context;

  API({Key key, this.context});

  final String url = "http://0.0.0.0:5000/";

  Future<bool> login(email, password) async {
    var response = await http.get(url, headers: {"email": email, "password": password});
    Map<String, dynamic> userData = jsonDecode(response.body);

    if (!userData.containsKey("loginStatus"))
      Provider.of<MessageProvider>(context, listen: false).showMessage(true);
    return userData.containsKey("loginStatus")? userData["loginStatus"]["isLoggedIn"] : false;
  }
}
