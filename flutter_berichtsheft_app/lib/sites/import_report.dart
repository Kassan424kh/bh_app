import 'package:flutter/material.dart';

class ImportReport extends StatelessWidget {
  final String title;

  ImportReport({Key key, this.title}) : super(key: key);

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
