import 'package:flutter/material.dart';
import 'package:flutter_berichtsheft_app/api/api.dart';
import 'package:flutter_berichtsheft_app/components/go_and_back_ui_buttons.dart';
import 'package:flutter_berichtsheft_app/components/site.dart';
import 'package:flutter_berichtsheft_app/components/ui_button.dart';
import 'package:flutter_berichtsheft_app/components/ui_date_picker.dart';
import 'package:flutter_berichtsheft_app/components/ui_switch_list_tile.dart';
import 'package:flutter_berichtsheft_app/components/ui_text_field.dart';
import 'package:flutter_berichtsheft_app/provider/provider.dart';
import 'package:flutter_berichtsheft_app/styling/styling.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateNewReport extends StatefulWidget {
  @override
  _CreateNewReportState createState() => _CreateNewReportState();
}

class _CreateNewReportState extends State<CreateNewReport> {
  DateTime _startReportDate = DateTime.now();
  DateTime _endReportDate = DateTime.now();
  DateTime _oneDayReportDate = DateTime.now();

  API _api;

  String _hours, _texts, _yearOfTraining, _date, _startDate, _endDate;

  bool _areMoreThenOneDay = false;

  DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    setState(() {
      _api = API(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _selectedTheme = Provider.of<StylingProvider>(context).selectedTheme;

    return Site(
      siteRoute: "/create-new",
      title: "Create new report",
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 50),
                UIButton(
                  leftWidget: Text(_areMoreThenOneDay ? "From Date" : "Day Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                  onPressed: () => UIDatePicker.d(context, _selectedTheme, _areMoreThenOneDay ? _startReportDate : _oneDayReportDate, (DateTime newSelectedDate) {
                    if (!newSelectedDate.isAfter(DateTime.now()))
                      setState(() {
                        if (!_areMoreThenOneDay) {
                          _oneDayReportDate = newSelectedDate;
                          _startDate = null;
                          _endDate = null;
                          _date = _dateFormat.format(_oneDayReportDate);
                        } else {
                          _startReportDate = newSelectedDate;
                          _date = null;
                          _startDate = _dateFormat.format(_startReportDate);
                          if (_startReportDate != null && _startReportDate != _endReportDate && _startReportDate.isAfter(_endReportDate)) _endReportDate = _startReportDate;
                        }
                      });
                  }),
                  text: (_areMoreThenOneDay ? _startDate : _date) == null ? "Select Date" : _dateFormat.format(_areMoreThenOneDay ? _startReportDate : _oneDayReportDate),
                  isActive: true,
                ),
                _areMoreThenOneDay ? SizedBox(width: 20) : Container(),
                _areMoreThenOneDay
                    ? UIButton(
                        leftWidget: Text("To Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                        onPressed: () => UIDatePicker.d(context, _selectedTheme, _endReportDate, (DateTime newSelectedDate) {
                          if (!newSelectedDate.isAfter(DateTime.now()))
                            setState(() {
                              _endReportDate = newSelectedDate;
                              _endDate = _dateFormat.format(_endReportDate);
                              if (_endReportDate != null && _startReportDate != _endReportDate && _endReportDate.isBefore(_startReportDate)) _startReportDate = _endReportDate;
                            });
                        }),
                        text: _endDate == null ? "Select Date" : _dateFormat.format(_endReportDate),
                        isActive: true,
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 20),
            UISwitchListTile(
              onChanged: (value) => setState(() => _areMoreThenOneDay = value),
              value: _areMoreThenOneDay,
            ),
            SizedBox(height: 20),
            UITextField(
              icon: Icon(Icons.calendar_today, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (year) {
                setState(() {
                  _yearOfTraining = year;
                });
              },
              marginLeft: 50,
              hintText: "Training Year",
            ),
            SizedBox(height: 20),
            UITextField(
              icon: Icon(Icons.access_time, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (hours) {
                setState(() {
                  _hours = hours;
                });
              },
              marginLeft: 50,
              hintText: "Work Hours",
            ),
            SizedBox(height: 20),
            UITextField(
              icon: Icon(Icons.short_text, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
              onChanged: (texts) {
                _texts = texts;
              },
              marginLeft: 50,
              hintText: "Report Text",
              maxLines: 10,
            ),
          ],
        ),
        SizedBox(height: 60),
        GoAndBackUiButtons(
          onClickGoButton: () {

            Map<dynamic, dynamic> reportData = {};
            reportData["hours"] = _hours;
            reportData["text"] = _texts;
            reportData["yearOfTraining"] = _yearOfTraining;
            if (_date != null)
              reportData["date"] = _date;
            else if (_startDate != null && _endDate != null){
              reportData["startDate"] = _startDate;
              reportData["endDate"] = _endDate;
            }

            if (_hours != null && _texts != null && _yearOfTraining != null && (_date != null || (_startDate != null && _endDate != null))) {
              _api.createNewReport(reportData);
            }else
              Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Please complete report data");
            },
        )
      ],
    );
  }
}
