import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String title;

  Login({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(),
    );
  }
}