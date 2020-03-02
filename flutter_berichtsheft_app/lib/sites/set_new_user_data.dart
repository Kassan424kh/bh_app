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

class SetNewUserData extends StatefulWidget {
  @override
  _SetNewUserDataState createState() => _SetNewUserDataState();
}

class _SetNewUserDataState extends State<SetNewUserData> {
  DateTime _birthdayDate = DateTime.now();
  DateTime _startDateTraining = DateTime.now();
  DateTime _endDateTraining = DateTime.now();
  bool _isUserTrainees = false;

  API _api;

  String _birthday, _startDateTrainingText, _endDateTrainingText, _typeOfTraining;

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
      siteRoute: "/set-new-user-data",
      title: "Set new user data",
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UISwitchListTile(
              text: "I'm Trainees",
              width: 250,
              onChanged: (value) => setState(() => _isUserTrainees = value),
              value: _isUserTrainees,
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 50),
                UIButton(
                  leftWidget: Text("Birthday ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                  onPressed: () => UIDatePicker.d(context, _selectedTheme, _birthdayDate, (DateTime newSelectedDate) {
                    if (!newSelectedDate.isAfter(DateTime.now()))
                      setState(() {
                        _birthdayDate = newSelectedDate;
                        _birthday = _dateFormat.format(_birthdayDate);
                      });
                  }),
                  text: _birthday == null ? "Select Date" : _dateFormat.format(_birthdayDate),
                  isActive: true,
                ),
              ],
            ),
            _isUserTrainees
                ? Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      UITextField(
                        icon: Icon(Icons.calendar_today, color: _selectedTheme[ElementStylingParameters.headerTextColor]),
                        onChanged: (typeOfTraining) {
                          setState(() {
                            _typeOfTraining = typeOfTraining;
                          });
                        },
                        marginLeft: 50,
                        hintText: "Training Type",
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          SizedBox(width: 50),
                          UIButton(
                            leftWidget: Text("Start Training Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                            onPressed: () => UIDatePicker.d(context, _selectedTheme, _startDateTraining, (DateTime newSelectedDate) {
                              if (!newSelectedDate.isAfter(DateTime.now()))
                                setState(() {
                                  _startDateTraining = newSelectedDate;
                                  _startDateTrainingText = _dateFormat.format(_startDateTraining);
                                });
                            }),
                            text: _startDateTrainingText == null ? "Select Date" : _dateFormat.format(_startDateTraining),
                            isActive: true,
                          ),
                          SizedBox(width: 20),
                          UIButton(
                            leftWidget: Text("End Training Date ", style: TextStyle(color: _selectedTheme[ElementStylingParameters.inputHintTextColor])),
                            onPressed: () => UIDatePicker.d(
                              context,
                              _selectedTheme,
                              _endDateTraining,
                              (DateTime newSelectedDate) {
                                if (!newSelectedDate.isAfter(
                                  DateTime.now().add(
                                    Duration(days: 1095),
                                  ),
                                ))
                                  setState(() {
                                    _endDateTraining = newSelectedDate;
                                    _endDateTrainingText = _dateFormat.format(_endDateTraining);
                                  });
                              },
                              maxDate: DateTime.now().add(
                                Duration(days: 1095),
                              ),
                            ),
                            text: _endDateTrainingText == null ? "Select Date" : _dateFormat.format(_endDateTraining),
                            isActive: true,
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        SizedBox(height: 60),
        GoAndBackUiButtons(
          onClickGoButton: () {
            Map<dynamic, dynamic> reportData = {};

            reportData["birthday"] = _birthday;
            reportData["is_trainees"] = _isUserTrainees;
            if (_isUserTrainees) {
              reportData["typeTraining"] = _typeOfTraining;
              reportData["startTrainingDate"] = _startDateTrainingText;
              reportData["endTrainingDate"] = _endDateTrainingText;
            }

            if (_birthday != null) {
              _api.addDataToNewUser(reportData);
            } else
              Provider.of<MessageProvider>(context, listen: false).showMessage(true, messageText: "Please complete report data");
          },
        )
      ],
    );
  }
}
