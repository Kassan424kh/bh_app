import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/sites/control_panel.dart';
import 'package:flutter_berichtsheft_app/sites/create_new_report.dart';
import 'package:flutter_berichtsheft_app/sites/edit_report.dart';
import 'package:flutter_berichtsheft_app/sites/error_404.dart';
import 'package:flutter_berichtsheft_app/sites/home.dart';
import 'package:flutter_berichtsheft_app/sites/import_report.dart';
import 'package:flutter_berichtsheft_app/sites/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berichtsheft Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}