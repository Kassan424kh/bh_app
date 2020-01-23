import 'package:flutter/material.dart';

class EditReport extends StatelessWidget {
  final String title;

  EditReport({Key key, this.title}) : super(key: key);

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
