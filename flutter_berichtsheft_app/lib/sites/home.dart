import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/null_image.dart';
import 'package:flutter_berichtsheft_app/components/report_list_tile.dart';
import 'package:flutter_berichtsheft_app/components/reports_data_table.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();
  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  API _api;
  List<dynamic> _listOfReports = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      _listOfReports.clear();
      _api = API(context: context);
    });

    _api.reports.then((reports) {
      try {
        setState(() {
          _listOfReports = reports;
        });
        List<int> _listOfReportsIds = [];
        for (var i = 0; i < reports.length; i++) _listOfReportsIds.add(reports[i]["r_id"]);

        Provider.of<ReportsProvider>(context, listen: false).setReportsIds(_listOfReportsIds);
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;
    return Site(
      siteRoute: "/home",
      title: "Home",
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Delete reports button
            UIButton(
              onPressed: () {
                bool areReportsSelected = Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReportIds.length > 0;
                Provider.of<MessageProvider>(context, listen: false).showMessage(
                  true,
                  messageText: areReportsSelected ? "Are you sure, you want to delete selected reports?" : "There are no selected reports",
                  okButton: areReportsSelected
                      ? () {
                          _api.deleteReports(Provider.of<ReportsProvider>(context, listen: false).listOfSelectedReportIds);
                        }
                      : null,
                );
              },
              leftWidget: Icon(Icons.delete_outline),
              isActive: true,
              withoutLeftWidgetSpace: true,
            ),
            SizedBox(width: 20),

            // print reports button
            UIButton(
              onPressed: () {},
              leftWidget: Icon(Icons.print),
              isActive: true,
              withoutLeftWidgetSpace: true,
            ),
            SizedBox(width: 20),

            // search button field from selected date
            UIButton(
              leftWidget: Text("From", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
              onPressed: () => UIDatePicker.d(context, _selectedTheme, _fromDate, (DateTime newSelectedDate) {
                if (newSelectedDate != null && newSelectedDate != _fromDate && newSelectedDate.isBefore(_toDate))
                  setState(() {
                    _fromDate = newSelectedDate;
                  });
              }),
              text: _dateFormat.format(_fromDate),
              hiddenText: _dateFormat.format(_fromDate) == _dateFormat.format(DateTime.now()),
              isActive: true,
            ),
            SizedBox(width: 20),

            // search button field to selected date
            UIButton(
              leftWidget: Text("To", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
              onPressed: () => UIDatePicker.d(context, _selectedTheme, _toDate, (DateTime newSelectedDate) {
                if (newSelectedDate != null && newSelectedDate != _toDate)
                  setState(() {
                    _toDate = newSelectedDate;
                  });
                if (newSelectedDate.isBefore(_fromDate))
                  setState(() {
                    _fromDate = _toDate;
                  });
              }),
              text: _dateFormat.format(_toDate),
              isActive: true,
            ),
          ],
        ),
        SizedBox(height: 20),
        ReportsDataTable(
          listOfReports: _listOfReports,
          nullSiteIcon: SitesIcons.nullHomeReports,
        )
      ],
    );
  }
}
