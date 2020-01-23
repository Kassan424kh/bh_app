import 'package:flutter/material.dart';

class Error404 extends StatelessWidget {
  final String title;

  Error404({Key key, this.title}) : super(key: key);

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
