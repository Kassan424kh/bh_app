import 'package:flutter/cupertino.dart';
import 'package:flutter_berichtsheft_app/sites/create_new_report.dart';
import 'package:flutter_berichtsheft_app/sites/deleted_reports.dart';
import 'package:flutter_berichtsheft_app/sites/draft_reports.dart';
import 'package:flutter_berichtsheft_app/sites/home.dart';
import 'package:flutter_berichtsheft_app/sites/import_reports.dart';
import 'package:flutter_berichtsheft_app/sites/search.dart';
import 'package:flutter_berichtsheft_app/sites/set_new_user_data.dart';

class Routes{
  static Map<String, Widget> routes = {
    "/": Home(),
    "/home": Home(),
    "/search": Search(),
    "/set-new-user-data": SetNewUserData(),
    "/import-reports": ImportReports(),
    "/create-new": CreateNewReport(),
    "/deleted-reports": DeletedReports(),
    "/draft-reports": DraftReports(),
  };
}