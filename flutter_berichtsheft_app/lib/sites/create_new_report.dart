import 'package:flutter/material.dart';

class CreateNewReport extends StatelessWidget {
  final String title;

  CreateNewReport({Key key, this.title}) : super(key: key);

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
