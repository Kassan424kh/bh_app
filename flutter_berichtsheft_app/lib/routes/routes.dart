import 'package:flutter/cupertino.dart';
import 'package:flutter_berichtsheft_app/sites/create_new_report.dart';
import 'package:flutter_berichtsheft_app/sites/deleted_reports.dart';
import 'package:flutter_berichtsheft_app/sites/draft_reports.dart';
import 'package:flutter_berichtsheft_app/sites/home.dart';
import 'package:flutter_berichtsheft_app/sites/import_reports.dart';

class Routes{
  static Map<String, Widget> routes = {
    "/": Home(),
    "/home": Home(),
    "/import-reports": ImportReports(),
    "/create-new": CreateNewReport(),
    "/deleted-reports": DeletedReports(),
    "/draft-reports": DraftReports(),
  };
}