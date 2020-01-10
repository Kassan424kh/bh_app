import 'package:flutter/material.dart';

class ControlPanel extends StatelessWidget {
  final String title;

  ControlPanel({Key key, this.title}) : super(key: key);

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
